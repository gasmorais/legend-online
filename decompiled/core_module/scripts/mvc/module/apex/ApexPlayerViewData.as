package mvc.module.apex
{
   import com.road.yishi.proto.apex.ApexPlayerViewMsg;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class ApexPlayerViewData
   {
      
      public var arm:String;
      
      public var cloth:String;
      
      public var wing:String;
      
      public var hat:String;
      
      public var hideFashion:Boolean;
      
      public var fashionArm:String;
      
      public var fashionCloth:String;
      
      public var isDragonTalker:Boolean;
      
      public var job:int;
      
      public var nickName:String;
      
      public var serverName:String;
      
      public var userId:int;
      
      public var fightCapacity:int;
      
      public var vipType:int;
      
      public var heroTempId:int;
      
      private var _thaneInfo:ThaneInfo;
      
      public function ApexPlayerViewData(param1:ApexPlayerViewMsg)
      {
         super();
         _thaneInfo = new ThaneInfo();
         _thaneInfo.armsEquipAvata = this.arm = param1.arm;
         _thaneInfo.bodyEquipAvata = this.cloth = param1.cloth;
         _thaneInfo.armsFashionAvata = this.fashionArm = param1.fashionArm;
         _thaneInfo.bodyFashionAvata = this.fashionCloth = param1.fashionCloth;
         _thaneInfo.fightingCapacity = this.fightCapacity = param1.fightCapacity;
         _thaneInfo.hairEquipAvata = this.hat = param1.hat;
         _thaneInfo.hideFashion = this.hideFashion = param1.hideFashion;
         _thaneInfo.isOpenDragonTalker = this.isDragonTalker = param1.isDragonTalker;
         _thaneInfo.job = this.job = param1.job;
         _thaneInfo.nickName = this.nickName = param1.nickName;
         _thaneInfo.userId = this.userId = int(param1.playerUid);
         _thaneInfo.serviceName = this.serverName = param1.serverName;
         _thaneInfo.vipType = this.vipType = param1.vipType;
         _thaneInfo.wingAvata = this.wing = param1.wing;
         _thaneInfo.templateId = this.heroTempId = param1.heroTempId;
         _thaneInfo.hairFashionAvata = this.hat = param1.hat;
      }
      
      public function get thaneInfo() : ThaneInfo
      {
         return _thaneInfo;
      }
   }
}

