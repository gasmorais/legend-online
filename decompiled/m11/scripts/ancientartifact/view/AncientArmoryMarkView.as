package ancientartifact.view
{
   import ancientartifact.view.item.AncientArmoryItem;
   import ancientartifact.view.item.AncientArmoryMarkItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class AncientArmoryMarkView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _jiantou:Image;
      
      private var _iconItem:Image;
      
      private var _itemView:AncientArmoryItem;
      
      private var _greenBar:MovieClip;
      
      private var _currentItem:AncientArmoryMarkItem;
      
      private var _nextItem:AncientArmoryMarkItem;
      
      private var _maxItem:AncientArmoryMarkItem;
      
      private var _proseTxt:FilterFrameText;
      
      private var _hasNumTxt:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _markBtn:IconButton;
      
      private var _data:AncientArmoryInfo;
      
      private var _maxCount:int;
      
      private var _trainCount:int;
      
      public function AncientArmoryMarkView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryMarkBack");
         _itemView = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.ancientartifact.advanceProgressBar");
         _jiantou = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryJianTou");
         _iconItem = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryMarkItem");
         _proseTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryProseTxt");
         _hasNumTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryHasNumTxt");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryInputNumTxt");
         _markBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryMarkBtn");
         _currentItem = new AncientArmoryMarkItem(1);
         _nextItem = new AncientArmoryMarkItem(2);
         _maxItem = new AncientArmoryMarkItem(3);
         addChild(_back);
         addChild(_itemView);
         addChild(_jiantou);
         addChild(_iconItem);
         addChild(_greenBar);
         addChild(_currentItem);
         addChild(_nextItem);
         addChild(_maxItem);
         addChild(_proseTxt);
         addChild(_hasNumTxt);
         addChild(_inputTxt);
         addChild(_markBtn);
         _greenBar.x = 114;
         _greenBar.y = 76;
         _currentItem.x = 10;
         _currentItem.y = 145;
         _nextItem.x = 220;
         _nextItem.y = 145;
         _maxItem.x = 120;
         _maxItem.y = 145;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(6260001);
         if(_loc1_)
         {
            _iconItem.tipData = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.hasMaterialText.text",_loc1_.TemplateName,_loc1_.Description);
         }
         initInfo();
      }
      
      private function initEvent() : void
      {
         _markBtn.addEventListener("click",__onClick);
         _inputTxt.addEventListener("change",__buyNumChange);
         model.addEventListener("ARMORY_CHOOSE_DATA",__getMarkInfos);
      }
      
      private function initInfo() : void
      {
         _inputTxt.text = "1";
         _maxCount = GoodsManager.instance.getBagCountByTempId(1,6260001);
         _hasNumTxt.text = _maxCount.toString();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 1;
         _proseTxt.text = _loc3_ + "/" + _loc2_;
         _loc1_ = _loc3_ / _loc2_ * 100;
         _loc1_ = int(_loc1_ > 100 ? 100 : _loc1_);
         _greenBar.gotoAndStop(_loc1_);
         _currentItem.visible = false;
         _nextItem.visible = false;
         _maxItem.visible = false;
         _jiantou.visible = false;
         _itemView.data = null;
         _markBtn.enable = false;
         _trainCount = int(_inputTxt.text);
      }
      
      private function __getMarkInfos(param1:AncientArtifactEvent) : void
      {
         _data = param1.data as AncientArmoryInfo;
         initInfo();
         if(!_data)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 1;
         _itemView.data = _data;
         var _loc5_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_data.grades + 1,138,_data.profile);
         if(!_loc5_)
         {
            _currentItem.visible = false;
            _nextItem.visible = false;
            _jiantou.visible = false;
            _maxItem.visible = true;
            _markBtn.enable = false;
            _greenBar.gotoAndStop(100);
            _proseTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTips04");
            _maxItem.data = _data;
         }
         else
         {
            _currentItem.visible = true;
            _nextItem.visible = true;
            _jiantou.visible = true;
            _maxItem.visible = false;
            _markBtn.enable = true;
            _loc3_ = int(_loc5_.Data);
            _loc4_ = int(_data.gp);
            _loc2_ = _loc4_ / _loc3_ * 100;
            _loc2_ = int(_loc2_ > 100 ? 100 : _loc2_);
            _greenBar.gotoAndStop(_loc2_);
            _proseTxt.text = _loc4_ + "/" + _loc3_;
            _currentItem.data = _data;
            _nextItem.data = _data;
         }
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         if(int(_inputTxt.text) > _maxCount)
         {
            _inputTxt.text = _maxCount.toString();
         }
         else if(int(_inputTxt.text) <= 0)
         {
            _inputTxt.text = "1";
         }
         _trainCount = int(_inputTxt.text);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_UPGRADE,0,_trainCount,false,0,_data.armoryId);
         }
      }
      
      private function removeEvent() : void
      {
         if(_markBtn)
         {
            _markBtn.removeEventListener("click",__onClick);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__buyNumChange);
         }
         model.removeEventListener("ARMORY_CHOOSE_DATA",__getMarkInfos);
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_jiantou);
         _jiantou = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_maxItem);
         _maxItem = null;
         ObjectUtils.disposeObject(_proseTxt);
         _proseTxt = null;
         ObjectUtils.disposeObject(_hasNumTxt);
         _hasNumTxt = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_markBtn);
         _markBtn = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         super.dispose();
      }
   }
}

