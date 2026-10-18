package yishi.datas.playerinfo
{
   import com.road.yishi.proto.campaign.MountInfoMsg;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import yishi.datas.ConfigInfoManager;
   
   public class SimpleMountInfo
   {
      
      public var power:int;
      
      public var intellect:int;
      
      public var physique:int;
      
      public var agility:int;
      
      public var powerGp:int;
      
      public var mountTempId:int;
      
      public var star:int = -1;
      
      public function SimpleMountInfo()
      {
         super();
      }
      
      public static function createFromMountInfoMsg(param1:MountInfoMsg) : SimpleMountInfo
      {
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:SimpleMountInfo = new SimpleMountInfo();
         _loc9_.powerGp = param1.powerGp;
         _loc9_.mountTempId = param1.mountTempId;
         _loc9_.star = param1.mountStarLv;
         var _loc3_:MountRefiningSoulInfo = new MountRefiningSoulInfo();
         _loc3_.strengthGrade = param1.refiningSoulPowerGrade;
         _loc3_.intellectGrade = param1.refiningSoulIntellectGrade;
         _loc3_.staminaGrade = param1.refiningSoulPhysiqueGrade;
         _loc3_.armorGrade = param1.refiningSoulAgilityGrade;
         var _loc7_:Array = ["power","intellect","agility","physique"];
         var _loc2_:int = param1.refiningSoulPowerGrade + param1.refiningSoulPhysiqueGrade + param1.refiningSoulAgilityGrade + param1.refiningSoulIntellectGrade;
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc10_ = Math.ceil(param1[_loc7_[_loc5_ - 1]] * _loc3_.getSkillAddPercent() / 100);
            _loc11_ = _loc3_.getPropAddPercentByPropName(PropertyInfo.PROP_NAME_ARR[_loc5_ - 1]);
            _loc8_ = ConfigInfoManager.instance.getMountRefiningSoulMaxValue();
            _loc6_ = Math.min(_loc10_,_loc8_);
            _loc4_ = Math.ceil(_loc6_ * _loc11_ / 100);
            _loc9_[_loc7_[_loc5_ - 1]] = param1[_loc7_[_loc5_ - 1]] + _loc4_;
            _loc5_++;
         }
         return _loc9_;
      }
      
      public static function createFromXml(param1:XML) : SimpleMountInfo
      {
         var _loc2_:SimpleMountInfo = new SimpleMountInfo();
         _loc2_.power = param1.@PowerGrade;
         _loc2_.intellect = param1.@IntellectGrade;
         _loc2_.physique = param1.@PhysiqueGrade;
         _loc2_.agility = param1.@AgilityGrade;
         _loc2_.powerGp = param1.@SoulScore;
         _loc2_.mountTempId = param1.@MountTempId;
         _loc2_.star = param1.@StarLevel;
         return _loc2_;
      }
   }
}

