package ancientartifact
{
   import ancientartifact.view.item.AncientResonateUpGradeItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AncientResonateUpGradeFrame extends Frame
   {
      
      private var _back:DisplayObject;
      
      private var _upGradeBtn:IconButton;
      
      private var _greenBar:MovieClip;
      
      private var _countIcon:Bitmap;
      
      private var _needItemImage:Image;
      
      private var _hasCountTxt:FilterFrameText;
      
      private var _trainCountTxt:FilterFrameText;
      
      private var _pressTxt:FilterFrameText;
      
      private var _currentItem:AncientResonateUpGradeItem;
      
      private var _nextItem:AncientResonateUpGradeItem;
      
      private var _maxCount:int;
      
      private var _trainCount:int;
      
      private var _data:AncientResonateInfo;
      
      public function AncientResonateUpGradeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceUpGradeFrame.resonateTitle");
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateUpGradeBack");
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateUpGradeBtn");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.ancientartifact.advanceProgressBar");
         _countIcon = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.upGradeViewBack10");
         _currentItem = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientResonateUpGradeItem01",[1]);
         _nextItem = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientResonateUpGradeItem02",[2]);
         _needItemImage = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateItemIcon");
         _hasCountTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateHasCountTxt");
         _trainCountTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateNeedTrianTxt");
         _pressTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateProseTxt");
         addToContent(_back);
         addToContent(_upGradeBtn);
         addToContent(_greenBar);
         addToContent(_countIcon);
         addToContent(_needItemImage);
         addToContent(_hasCountTxt);
         addToContent(_trainCountTxt);
         addToContent(_pressTxt);
         addToContent(_currentItem);
         addToContent(_nextItem);
         _greenBar.x = 74;
         _greenBar.y = 151;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(6260002);
         if(_loc1_)
         {
            _needItemImage.tipData = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.hasMaterialText.text",_loc1_.TemplateName,_loc1_.Description);
         }
      }
      
      private function initInfo() : void
      {
         var _loc1_:int = 0;
         var _loc4_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.posGrades + 1,137);
         var _loc5_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.posGrades,137);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_loc4_)
         {
            _loc3_ = int(_data.posGp);
            _greenBar.gotoAndStop(100);
            _currentItem.data = _data;
            _nextItem.data = _data;
            _pressTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTips04");
            _maxCount = GoodsManager.instance.getBagCountByTempId(1,6260002);
            _hasCountTxt.text = _maxCount.toString();
            _trainCountTxt.text = "1";
         }
         else
         {
            _loc2_ = _loc4_.Data - _loc5_.Data;
            _loc3_ = _data.posGp - _loc5_.Data;
            _loc1_ = _loc3_ / _loc2_ * 100;
            _loc1_ = int(_loc1_ > 100 ? 100 : _loc1_);
            _greenBar.gotoAndStop(_loc1_);
            _pressTxt.text = _loc3_ + "/" + _loc2_;
            _currentItem.data = _data;
            _nextItem.data = _data;
            _maxCount = GoodsManager.instance.getBagCountByTempId(1,6260002);
            _hasCountTxt.text = _maxCount.toString();
            _trainCountTxt.text = "1";
            _trainCount = int(_trainCountTxt.text);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _upGradeBtn.addEventListener("click",__upGradeOnClick);
         _trainCountTxt.addEventListener("change",__buyNumChange);
         model.addEventListener("RESONATE_INFO_UP_DATA",__updataInfo);
      }
      
      private function __updataInfo(param1:AncientArtifactEvent) : void
      {
         _data = model.getResonateInfoByPos(_data.pos);
         initInfo();
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         if(int(_trainCountTxt.text) > _maxCount)
         {
            _trainCountTxt.text = _maxCount.toString();
         }
         else if(int(_trainCountTxt.text) <= 0)
         {
            _trainCountTxt.text = "1";
         }
         _trainCount = int(_trainCountTxt.text);
      }
      
      private function __upGradeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_data.posGrades + 1,137);
         if(!_loc3_)
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTips04");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.RESON_UPGRADE,0,_trainCount,false,_data.pos);
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_upGradeBtn)
         {
            _upGradeBtn.removeEventListener("click",__upGradeOnClick);
         }
         if(_trainCountTxt)
         {
            _trainCountTxt.removeEventListener("change",__buyNumChange);
         }
         model.removeEventListener("RESONATE_INFO_UP_DATA",__updataInfo);
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function show(param1:Object = null) : void
      {
         _data = param1 as AncientResonateInfo;
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         initInfo();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_upGradeBtn);
         _upGradeBtn = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_countIcon);
         _countIcon = null;
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_needItemImage);
         _needItemImage = null;
         ObjectUtils.disposeObject(_hasCountTxt);
         _hasCountTxt = null;
         ObjectUtils.disposeObject(_trainCountTxt);
         _trainCountTxt = null;
         ObjectUtils.disposeObject(_pressTxt);
         _pressTxt = null;
         super.dispose();
      }
   }
}

