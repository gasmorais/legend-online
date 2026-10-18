package playerinfo.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SNSEvent;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.SNSManager;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.HeadIconCell;
   
   public class InfoView extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _back:MutipleImage;
      
      private var _back2:MutipleImage;
      
      private var _sign:FilterFrameText;
      
      private var _sex:FilterFrameText;
      
      private var _blood:FilterFrameText;
      
      private var _birth:FilterFrameText;
      
      private var _star:FilterFrameText;
      
      private var _address:FilterFrameText;
      
      private var _headCell:HeadIconCell;
      
      private var _nickName:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _charmsTxt:FilterFrameText;
      
      private var _honerValueTxt:FilterFrameText;
      
      private var _honerNameTxt:FilterFrameText;
      
      private var _thane:ThaneInfo;
      
      private var _equipDic:SimpleDictionary;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public function InfoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.FrameBack2");
         _back = ComponentFactory.Instance.creatComponentByStylename("army.imageBg");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("army.imageBg2");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoNameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoNameTxt");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoNameTxt");
         _charmsTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoNameTxt");
         _honerValueTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoNameTxt");
         _honerNameTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThanehonouerNameTxt");
         _sign = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoSignTxt");
         _sex = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoSexTxt");
         _blood = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoBloodTxt");
         _birth = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoBirthTxt");
         _star = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoStarTxt");
         _address = ComponentFactory.Instance.creatComponentByStylename("playerinfo.PlayerInfoAddressTxt");
         _headCell = ComponentFactory.Instance.creatCustomObject("playerinfo.PlayerInfoHeadCell");
         _headCell.type = "head";
         addChild(_bg);
         _bg.x = _bg.y = 0;
         addChild(_back);
         _back.x = 0;
         _back.y = 0;
         addChild(_back2);
         addChild(_nickName);
         addChild(_consortiaTxt);
         _consortiaTxt.y = 37;
         addChild(_jobTxt);
         _jobTxt.y = 59;
         addChild(_charmsTxt);
         _charmsTxt.y = 81;
         addChild(_honerValueTxt);
         _honerValueTxt.y = 106;
         addChild(_honerNameTxt);
         addChild(_sign);
         addChild(_sex);
         addChild(_blood);
         addChild(_birth);
         addChild(_star);
         addChild(_address);
         addChild(_headCell);
      }
      
      public function initData(param1:ThaneInfo, param2:SimpleDictionary) : void
      {
         _thane = param1;
         _equipDic = new SimpleDictionary(true);
         _equipDic.setDictionary(param2);
         if(snsManager.model.hasSnsTemp)
         {
            refreshView();
         }
         else
         {
            snsManager.addEventListener("SNSTEMP_LOAD_COMPLETE",__snstempLoadCompleteHandler);
            snsManager.loadSnsTemplate();
         }
         if(_thane.vocationGrades > 0)
         {
            _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("playerinfo.VocationIconBtn");
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_thane.templateInfo.Job,_thane.vocationStep,_thane.vocationLevel);
            _vocationIcon.setFrame(_thane.vocationLevel);
            _vocationIcon.visible = true;
            _jobTxt.x = 195;
            addChild(_vocationIcon);
         }
      }
      
      private function __snstempLoadCompleteHandler(param1:SNSEvent) : void
      {
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snstempLoadCompleteHandler);
         refreshView();
      }
      
      private function removeEvent() : void
      {
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snstempLoadCompleteHandler);
      }
      
      private function refreshView() : void
      {
         clean();
         if(!_thane)
         {
            return;
         }
         if(_thane.snsInfo.headId > 0)
         {
            _headCell.headId = _thane.snsInfo.headId;
         }
         else
         {
            _headCell.headId = _thane.templateId;
         }
         _nickName.text = _thane.nickName;
         _sign.text = _thane.snsInfo.sign;
         _sex.text = _thane.snsInfo.sexName;
         _star.text = _thane.snsInfo.horoscopeName;
         _blood.text = _thane.snsInfo.bloodName;
         _address.text = _thane.snsInfo.countryName + "   " + _thane.snsInfo.provinceName + "   " + _thane.snsInfo.cityName;
         _address.width = _address.textWidth + 8;
         _back2.setChildSize(4,_address.textWidth + 13,24);
         _consortiaTxt.text = _thane.consortiaName ? _thane.consortiaName : LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         _jobTxt.text = JobType.getJobName(_thane.templateInfo.Job);
         _charmsTxt.text = _thane.charms.toString();
         _honerValueTxt.text = _thane.honer.toString();
         _honerNameTxt.text = _thane.honerTemp.TemplateName;
         _honerNameTxt.x = _honerValueTxt.x + _honerValueTxt.textWidth + 10;
         if(_thane.snsInfo.birthYear > 0)
         {
            _birth.text = LanguageMgr.GetTranslation("public.dateType",_thane.snsInfo.birthYear,_thane.snsInfo.birthMonth,_thane.snsInfo.birthDay);
         }
         else
         {
            _birth.text = LanguageMgr.GetTranslation("friends.findfriend.FindResultItem.unknown");
         }
      }
      
      private function get snsManager() : SNSManager
      {
         return SNSManager.instance;
      }
      
      private function clean() : void
      {
         _sign.text = "";
         _sex.text = "";
         _blood.text = "";
         _birth.text = "";
         _star.text = "";
         _address.text = "";
         _nickName.text = "";
         _consortiaTxt.text = "";
         _jobTxt.text = "";
         _charmsTxt.text = "";
         _honerValueTxt.text = "";
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_equipDic)
         {
            _equipDic.clear();
            _equipDic = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_charmsTxt);
         _charmsTxt = null;
         ObjectUtils.disposeObject(_honerValueTxt);
         _honerValueTxt = null;
         ObjectUtils.disposeObject(_honerNameTxt);
         _honerNameTxt = null;
         ObjectUtils.disposeObject(_sign);
         _sign = null;
         ObjectUtils.disposeObject(_sex);
         _sex = null;
         ObjectUtils.disposeObject(_blood);
         _blood = null;
         ObjectUtils.disposeObject(_birth);
         _birth = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         ObjectUtils.disposeObject(_address);
         _address = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
      }
   }
}

