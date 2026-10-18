package playerinfo.view.playerattribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class PlayerSummaryAttributeView extends Component
   {
      
      private var _thaneNameTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _gappellTxt:GradientText;
      
      private var _honerNameTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _charmsTxt:FilterFrameText;
      
      private var _exploitsTxt:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _honerTip:StripView;
      
      public function PlayerSummaryAttributeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _thaneNameTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneNameTxt");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneJobTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneLevelTxt");
         _honerNameTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThanehonouerNameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneConsortiaTxt");
         _charmsTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneCharmsTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneCombatPowerTxt");
         _exploitsTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneExploitsTxt");
         _honerTip = ComponentFactory.Instance.creatCustomObject("army.attribute.HonerTip");
         addChild(_thaneNameTxt);
         addChild(_jobTxt);
         addChild(_levelTxt);
         addChild(_honerNameTxt);
         addChild(_consortiaTxt);
         addChild(_exploitsTxt);
         addChild(_rankTxt);
         addChild(_charmsTxt);
         addChild(_honerTip);
      }
      
      public function refresh(param1:ThaneInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1)
         {
            _thaneNameTxt.text = param1.nickName;
            _jobTxt.text = JobType.getJobName(param1.templateInfo.Job);
            _levelTxt.text = LanguageMgr.GetTranslation("public.level2",param1.grades);
            _honerNameTxt.text = param1.honerTemp.TemplateName;
            _consortiaTxt.text = param1.consortiaName ? param1.consortiaName : LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            _charmsTxt.text = param1.charms.toString();
            _exploitsTxt.text = param1.honer.toString();
            _rankTxt.text = param1.fightingCapacity.toString();
            _honerNameTxt.x = _exploitsTxt.x + _exploitsTxt.textWidth + 10;
            _loc2_ = getHonerStyle(param1);
            _loc3_ = getHonerName(param1);
            setGradientAppell(_loc2_,_loc3_);
         }
      }
      
      private function setGradientAppell(param1:String, param2:String) : void
      {
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         _gappellTxt = ComponentFactory.Instance.creatComponentByStylename(param1);
         _gappellTxt.text = param2;
         _gappellTxt.x = 55;
         _gappellTxt.y = 83;
         _gappellTxt.mouseEnabled = false;
         _gappellTxt.mouseChildren = false;
         addChild(_gappellTxt);
      }
      
      public function getHonerStyle(param1:ThaneInfo) : String
      {
         var _loc2_:String = "army.HonerText";
         if(VersionSwitch.APPELL && param1.appellId != 0)
         {
            _loc2_ += param1.appellInfo.Quality;
         }
         return _loc2_;
      }
      
      public function getHonerName(param1:ThaneInfo) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         if(VersionSwitch.APPELL && param1.appellId != 0)
         {
            _loc2_ = param1.appellInfo.Title;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_thaneNameTxt);
         _thaneNameTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_gappellTxt);
         _gappellTxt = null;
         ObjectUtils.disposeObject(_honerNameTxt);
         _honerNameTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_charmsTxt);
         _charmsTxt = null;
         ObjectUtils.disposeObject(_exploitsTxt);
         _exploitsTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_honerTip);
         _honerTip = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

