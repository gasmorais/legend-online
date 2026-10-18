package mvc.module.theseusdoublepvp
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class TheseusDoublePvpShowInfo
   {
      
      public var seasonId:int;
      
      public var rank:int;
      
      public var integral:int;
      
      public var pvpId:int;
      
      public var startDate:String;
      
      public var stopDate:String;
      
      public var playerUid:String;
      
      public var nickName:String;
      
      public var serverName:String;
      
      public var arm:String;
      
      public var cloth:String;
      
      public var wing:String;
      
      public var hat:String;
      
      public var fashionArm:String;
      
      public var fashionCloth:String;
      
      public var hideFashion:Boolean;
      
      public var isDragonTalker:Boolean;
      
      public var job:int;
      
      public var fightCapacity:int;
      
      public var vipType:int;
      
      public var heroTempId:int;
      
      public var canZan:Boolean = false;
      
      private var _thaneInfo:ThaneInfo;
      
      public function TheseusDoublePvpShowInfo()
      {
         super();
         _thaneInfo = new ThaneInfo();
      }
      
      public function updateThane() : void
      {
         _thaneInfo.armsEquipAvata = this.arm;
         _thaneInfo.bodyEquipAvata = this.cloth;
         _thaneInfo.armsFashionAvata = this.fashionArm;
         _thaneInfo.bodyFashionAvata = this.fashionCloth;
         _thaneInfo.fightingCapacity = this.fightCapacity;
         _thaneInfo.hairEquipAvata = this.hat;
         _thaneInfo.hideFashion = this.hideFashion;
         _thaneInfo.isOpenDragonTalker = this.isDragonTalker;
         _thaneInfo.job = this.job;
         _thaneInfo.nickName = this.nickName;
         _thaneInfo.userId = int(this.playerUid);
         _thaneInfo.serviceName = this.serverName;
         _thaneInfo.vipType = this.vipType;
         _thaneInfo.wingAvata = this.wing;
         _thaneInfo.templateId = this.heroTempId;
         _thaneInfo.hairFashionAvata = this.hat;
      }
      
      public function get thaneInfo() : ThaneInfo
      {
         return _thaneInfo;
      }
   }
}

