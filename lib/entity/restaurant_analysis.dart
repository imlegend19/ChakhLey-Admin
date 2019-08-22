class RestaurantAnalysis {
  final int id;
  final String name;
  final int totalIncome;
  final int totalOrders;
  final int incomeToday;
  final int ordersToday;
  final int commission;
  final Map<String, dynamic> mostLikedProduct;
  final List<dynamic> topTenProducts;
  final int incomeMonth;
  final int ordersMonth;
  final int amountAfterCommission;

  RestaurantAnalysis(
      {this.id,
      this.name,
      this.totalIncome,
      this.totalOrders,
      this.incomeToday,
      this.ordersToday,
      this.commission,
      this.mostLikedProduct,
      this.topTenProducts,
      this.incomeMonth,
      this.ordersMonth,
      this.amountAfterCommission});
}
