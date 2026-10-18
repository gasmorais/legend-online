package armyII.viewII.holydragonsoul
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class HolyDragonSoulLeadItem extends Component
   {
      
      private var _typeImage:ScaleFrameImage;
      
      private var _data:UpgradeTemplateInfo;
      
      private var _index:int;
      
      private var _filter:UIFilter;
      
      private var _isSelf:Boolean;
      
      private var _thaneInfo:ThaneInfo;
      
      public function HolyDragonSoulLeadItem(param1:Boolean = true, param2:ThaneInfo = null)
      {
         super();
         _isSelf = param1;
         _thaneInfo = param2;
         _typeImage = ComponentFactory.Instance.creatComponentByStylename("HolyDragonSoulLeadItem.typeImage");
         _filter = new UIFilter();
         _filter.setGrayFilter(_typeImage);
         addChild(_typeImage);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _typeImage.setFrame(_index);
      }
      
      public function set data(param1:UpgradeTemplateInfo) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_data.ActiveObject);
         if(dragonSoulGrade < _data.Grades)
         {
            _filter.setGrayFilter(_typeImage);
            if(_loc2_)
            {
               _typeImage.tipData = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.active",int(_data.Grades / 6) + 1) + "\n" + _loc2_.Description;
            }
         }
         else
         {
            _filter.setNormalFilter(_typeImage);
            if(_loc2_)
            {
               _typeImage.tipData = _loc2_.Description;
            }
         }
      }
      
      private function get dragonSoulGrade() : int
      {
         if(_isSelf)
         {
            return playerInfo.dragonSoulGrade;
         }
         return _thaneInfo.dragonSoulGrade;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_typeImage);
         _typeImage = null;
      }
      
      override public function dispose() : void
      {
         unInitView();
      }
   }
}

