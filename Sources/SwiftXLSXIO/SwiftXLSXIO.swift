import Clibxlsxio
import Foundation

public struct ExcelIO {
	enum Error:Swift.Error {
		case unableToOpen
		case sheetNotFound
	}
	public static func parseFile(path:URL) throws -> [[String]] {
		guard let xlReader = xlsxioread_open(path.path) else {
			throw Error.unableToOpen
		}
		defer {
			xlsxioread_close(xlReader)
		}
		guard let forecastSheet = xlsxioread_sheet_open(xlReader, "FORECAST", UInt32(XLSXIOREAD_SKIP_NONE)) else {
			throw Error.sheetNotFound
		}
		defer {
			xlsxioread_sheet_close(forecastSheet)
		}
		
		var buildRows = [[String]]()
		var blanks:UInt32 = 0
		while xlsxioread_sheet_next_row(forecastSheet) != 0 {
			var totalLen:size_t = 0
			var cols = [String]()
			while let value = xlsxioread_sheet_next_cell(forecastSheet) {
				defer {
					xlsxioread_free(value)
				}
				totalLen += strlen(value)
				cols.append(String(cString:value))
			}
			buildRows.append(cols)
			if totalLen == 0 && blanks < 10{
				blanks += 1;
			} else if blanks == 10 {
				return buildRows
			}
		}
		return buildRows
	}
}