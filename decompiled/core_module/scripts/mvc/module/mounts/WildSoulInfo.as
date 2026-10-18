package mvc.module.mounts
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class WildSoulInfo
   {
      
      private static var _upgradeInfoDic:Dictionary;
      
      public static const millisecondsPerDay:int = 86400000;
      
      public var templateId:int;
      
      public var isExist:Boolean;
      
      public var expairDate:Date;
      
      public var activeDate:Date;
      
      public var param1:int;
      
      public var param2:int;
      
      public var mountType:int;
      
      public var star:int = 0;
      
      public var bless:int = 0;
      
      public var isBuyFly:Boolean;
      
      public function WildSoulInfo()
      {
         super();
      }
      
      public static function getUpgradeInfoDic(param1:int) : Array
      {
         var _loc5_:String = null;
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         if(!_upgradeInfoDic)
         {
            _upgradeInfoDic = new Dictionary();
            _loc2_ = TempleteManager.instance.getTemplatesByType(37);
            for each(var _loc3_:UpgradeTemplateInfo in _loc2_)
            {
               _loc5_ = _loc3_.Types + "_" + _loc3_.TemplateId;
               if(!(_loc5_ in _upgradeInfoDic))
               {
                  _upgradeInfoDic[_loc5_] = [];
               }
               _loc4_ = _upgradeInfoDic[_loc5_];
               _loc4_[_loc3_.Grades] = _loc3_;
            }
         }
         _loc5_ = "37_" + param1;
         return _upgradeInfoDic[_loc5_];
      }
      
      public function get blessUpgradeInfo() : UpgradeTemplateInfo
      {
         var _loc1_:Array = WildSoulInfo.getUpgradeInfoDic(template.GradeType);
         if(_loc1_)
         {
            return _loc1_[star + 1] as UpgradeTemplateInfo;
         }
         return null;
      }
      
      public function get validity() : int
      {
         if(expairDate.fullYear == 2000)
         {
            return -1;
         }
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         return int((expairDate.time - _loc1_.time) / 1000 / 60 / 60 / 24);
      }
      
      public function get template() : MountTemplate
      {
         var _loc1_:Dictionary = TempleteManager.instance.mountTemplateDic;
         return _loc1_[templateId] == null ? new MountTemplate() : _loc1_[templateId];
      }
   }
}

