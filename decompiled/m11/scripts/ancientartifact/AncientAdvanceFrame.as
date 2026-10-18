package ancientartifact
{
   import ancientartifact.view.item.AncientStarsItem;
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AncientAdvanceFrame extends Frame implements IManualSize
   {
      
      public static const UPGRAD_TYPE:int = 136;
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
      private var _back:DisplayObject;
      
      private var _bg:Bitmap;
      
      private var _trainCountBg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _stars:AncientStarsItem;
      
      private var _lvlText:FilterFrameText;
      
      private var _currentNote:Bitmap;
      
      private var _nextNote:Bitmap;
      
      private var _trainCountBmp:Bitmap;
      
      private var _curAddTxt:FilterFrameText;
      
      private var _nextAddTxt:FilterFrameText;
      
      private var _curSkillTxt:FilterFrameText;
      
      private var _nextSkillTxt:FilterFrameText;
      
      private var _noteTxt:FilterFrameText;
      
      private var _ownStoneTxt:FilterFrameText;
      
      private var _advanceMetarial:ScaleFrameImage;
      
      private var _stoneTxt:FilterFrameText;
      
      private var _trainCountText:FilterFrameText;
      
      private var _advanceBtn:IconButton;
      
      private var _upgradeTemplates:Array;
      
      private var _maxGrade:int;
      
      private var _greenBar:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      public function AncientAdvanceFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,525,445);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AncientAdvanceFrame.bg");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.advanceBg");
         _trainCountBg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.trainCountBg");
         _icon = ComponentFactory.Instance.creatCustomObject("ancientartifact.BaseItemViewIcon3");
         _currentNote = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.currentNote");
         _nextNote = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.nextNote");
         _trainCountBmp = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.trainCountBmp");
         _curAddTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.curAddTxt");
         _nextAddTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.nextAddTxt");
         _curSkillTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.curSkillTxt");
         _nextSkillTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.nextSkillTxt");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.noteTxt");
         _ownStoneTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.ownStoneTxt");
         _advanceMetarial = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.advanceMetarialImage");
         _stoneTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.stoneTxt");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.trainCount");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvanceFrame.advanceBtn");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.ancientartifact.advanceProgressBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.advanceBar.progressTxt");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("AncientAdvanceFrame.lvlText");
         addToContent(_back);
         addToContent(_bg);
         addToContent(_trainCountBg);
         addToContent(_icon);
         addToContent(_currentNote);
         addToContent(_nextNote);
         addToContent(_trainCountBmp);
         addToContent(_lvlText);
         addToContent(_curAddTxt);
         addToContent(_nextAddTxt);
         addToContent(_curSkillTxt);
         addToContent(_nextSkillTxt);
         addToContent(_noteTxt);
         addToContent(_ownStoneTxt);
         addToContent(_advanceMetarial);
         addToContent(_stoneTxt);
         addToContent(_trainCountText);
         addToContent(_advanceBtn);
         addToContent(_greenBar);
         addToContent(_progressTxt);
         _trainCountText.text = "1";
         _upgradeTemplates = upgradeTemplates;
         _maxGrade = maxGrade;
         _noteTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.noteTxt");
         _advanceMetarial.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _advanceBtn.addEventListener("click",__advanceHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__onUpdateNumberHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_advanceBtn)
         {
            _advanceBtn.removeEventListener("click",__advanceHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__onUpdateNumberHandler);
         if(_trainCountText)
         {
            _trainCountText.removeEventListener("change",__textChangHandler);
         }
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function __advanceHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ADVANCE,_templateId,int(_trainCountText.text));
      }
      
      private function __onUpdateNumberHandler(param1:BagEvent = null) : void
      {
         _stoneTxt.text = ownStone.toString();
         _trainCountText.text = "1";
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         if(_loc2_ >= ownStone)
         {
            _trainCountText.text = ownStone.toString();
         }
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _templateId = AncientArtifactManager.instance.selectTempId;
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         _data = model.getArtifactInfoById(_templateId);
         clearData();
         _stoneTxt.text = ownStone.toString();
         _icon.icon = IconFactory.getCommonIconPath(_template.Icon);
         _ownStoneTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.ownName",ownName);
         _lvlText.text = LanguageMgr.GetTranslation("public.level2",_data.level);
         _stars = new AncientStarsItem(_template,_data);
         _stars.x = 193;
         _stars.y = 113;
         addChild(_stars);
         _curAddTxt.text = currentTemplte.ActiveObject + "%";
         _curSkillTxt.htmlText = getSkillDescription1(int(_template.Skills),_data.level);
         if(_maxGrade == _data.level)
         {
            _progressTxt.text = "max";
            _loc2_ = 100;
            _greenBar.gotoAndStop(_loc2_);
            _nextAddTxt.text = "";
            _nextSkillTxt.text = "";
         }
         else
         {
            _loc4_ = int(_data.gp);
            _loc3_ = int(upgradeTemplte.Data);
            _progressTxt.text = _loc4_ + "/" + _loc3_;
            _loc2_ = _loc4_ / _loc3_ * 100;
            _greenBar.gotoAndStop(_loc2_);
            _nextAddTxt.text = upgradeTemplte.ActiveObject + "%";
            _nextSkillTxt.htmlText = getSkillDescription2(int(_template.Skills),_data.level + 1);
         }
      }
      
      private function getSkillDescription1(param1:int, param2:int) : String
      {
         var _loc3_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(param1,param2);
         return "<textformat><font color=\'#3cd91d\'>" + _loc3_.TemplateName + "</font>\n" + _loc3_.Description + "</textformat>";
      }
      
      private function getSkillDescription2(param1:int, param2:int) : String
      {
         var _loc3_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(param1,param2);
         return "<textformat><font color=\'#ff0101\'>" + _loc3_.TemplateName + "</font>\n" + _loc3_.Description + "</textformat>";
      }
      
      private function clearData() : void
      {
         ObjectUtils.disposeObject(_stars);
         _stars = null;
      }
      
      private function get ownName() : String
      {
         var _loc2_:int = 0;
         _loc2_ = int(_upgradeTemplates[_data.level - 1].TemplateName);
         switch(_loc2_ - 212015)
         {
            case 0:
               _advanceMetarial.setFrame(1);
               break;
            case 1:
               _advanceMetarial.setFrame(2);
               break;
            case 2:
               _advanceMetarial.setFrame(3);
         }
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
         _advanceMetarial.tipData = _loc1_.Description;
         return _loc1_.TemplateName;
      }
      
      private function get ownStone() : int
      {
         var _loc1_:int = 0;
         _loc1_ = int(_upgradeTemplates[_data.level - 1].TemplateName);
         return GoodsManager.instance.getGoodsNumByTempId(_loc1_);
      }
      
      public function get upgradeTemplates() : Array
      {
         var _loc1_:Array = null;
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.getTemplatesByType(136);
            _loc1_.sortOn("Grades",16);
         }
         return _loc1_;
      }
      
      public function get maxGrade() : int
      {
         if(_upgradeTemplates.length == 0)
         {
            return 0;
         }
         return _upgradeTemplates[_upgradeTemplates.length - 1].Grades;
      }
      
      public function get currentTemplte() : UpgradeTemplateInfo
      {
         return _upgradeTemplates[_data.level - 1];
      }
      
      public function get upgradeTemplte() : UpgradeTemplateInfo
      {
         return _upgradeTemplates[_data.level];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function show(param1:int) : void
      {
         __updateViewHandler();
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_trainCountBg);
         _trainCountBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_stars);
         _stars = null;
         ObjectUtils.disposeObject(_currentNote);
         _currentNote = null;
         ObjectUtils.disposeObject(_nextNote);
         _nextNote = null;
         ObjectUtils.disposeObject(_trainCountBmp);
         _trainCountBmp = null;
         ObjectUtils.disposeObject(_curAddTxt);
         _curAddTxt = null;
         ObjectUtils.disposeObject(_nextAddTxt);
         _nextAddTxt = null;
         ObjectUtils.disposeObject(_curSkillTxt);
         _curSkillTxt = null;
         ObjectUtils.disposeObject(_nextSkillTxt);
         _nextSkillTxt = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         ObjectUtils.disposeObject(_ownStoneTxt);
         _ownStoneTxt = null;
         ObjectUtils.disposeObject(_stoneTxt);
         _stoneTxt = null;
         ObjectUtils.disposeObject(_trainCountText);
         _trainCountText = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_advanceMetarial);
         _advanceMetarial = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         _template = null;
         _data = null;
         _upgradeTemplates = null;
         super.dispose();
      }
   }
}

