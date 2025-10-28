enum TripStatus {
  pending('Pending Approval'),
  proposal('Proposal Sent'),
  ready('Ready for travel');

  final String value;
  const TripStatus(this.value);

  static TripStatus fromString(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains('pending')) return TripStatus.pending;
    if (lowerStatus.contains('proposal')) return TripStatus.proposal;
    if (lowerStatus.contains('ready')) return TripStatus.ready;
    return TripStatus.proposal; // default
  }
}
