import Foundation

struct ApiCenReport: Codable {
    let reportID: String
    let report: String?
    let reportTimeStamp: Int64
}

extension ApiCenReport {
    func toCenReport() -> CenReport {
        // The api omits the key if the report is empty, so we made it optional and default to empty string here.
        let report = self.report ?? ""

        guard
            let decodedData = Data(base64Encoded: report),
            let decodedReport = String(data: decodedData, encoding: .utf8)
        else {
            return CenReport(id: reportID, report: "Decoding error", timestamp: reportTimeStamp)
        }

        return CenReport(id: reportID, report: decodedReport, timestamp: reportTimeStamp)
    }
}
