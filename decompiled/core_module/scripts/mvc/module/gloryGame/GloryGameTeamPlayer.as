package mvc.module.gloryGame
{
   import com.road.yishi.proto.Glory.GloryPlayerViewMsg;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.DataUtils;
   
   public class GloryGameTeamPlayer
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
      
      public var playerUid:int;
      
      public var fightCapacity:int;
      
      public var vipType:int;
      
      public var heroTempId:int;
      
      public var teamUid:String;
      
      private var _thaneInfo:ThaneInfo;
      
      public function GloryGameTeamPlayer(param1:GloryPlayerViewMsg)
      {
         super();
         DataUtils.fillData(this,param1);
         _thaneInfo = new ThaneInfo();
         _thaneInfo.armsEquipAvata = param1.arm;
         _thaneInfo.bodyEquipAvata = param1.cloth;
         _thaneInfo.armsFashionAvata = param1.fashionArm;
         _thaneInfo.bodyFashionAvata = param1.fashionCloth;
         _thaneInfo.fightingCapacity = param1.fightCapacity;
         _thaneInfo.hairEquipAvata = param1.hat;
         _thaneInfo.hideFashion = param1.hideFashion;
         _thaneInfo.isOpenDragonTalker = param1.isDragonTalker;
         _thaneInfo.job = param1.job;
         _thaneInfo.nickName = param1.nickName;
         _thaneInfo.userId = param1.playerUid;
         _thaneInfo.serviceName = param1.serverName;
         _thaneInfo.vipType = param1.vipType;
         _thaneInfo.wingAvata = param1.wing;
         _thaneInfo.templateId = param1.heroTempId;
         _thaneInfo.hairFashionAvata = param1.hat;
      }
      
      public function get thaneInfo() : ThaneInfo
      {
         return _thaneInfo;
      }
   }
}

