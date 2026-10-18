package ancientartifact.view.item
{
   import ancientartifact.view.AcnientCheckList;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class AncientResonateItem extends Component
   {
      
      private var _iconView:BaseIconView;
      
      private var _addItemImage:Image;
      
      private var _selectBtn:BaseButton;
      
      private var _upGradeBtn:BaseButton;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _data:AncientResonateInfo;
      
      private var _anctientId:int;
      
      private var _filter:UIFilter;
      
      private var _pos:int;
      
      private var _checkListView:AcnientCheckList;
      
      public function AncientResonateItem(param1:int)
      {
         _pos = param1;
         super();
         initView();
         if(_pos != 6)
         {
            initEvent();
         }
      }
      
      private function initView() : void
      {
         _addItemImage = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.addItemIamge");
         _iconView = ComponentFactory.Instance.creatCustomObject("ancientartifact.ResonateItemIcon");
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateUpGrade");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateItemTipsTxt");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("AncientResonateItem.selectBtn");
         addChild(_addItemImage);
         addChild(_selectBtn);
         addChild(_iconView);
         addChild(_upGradeBtn);
         addChild(_tipsTxt);
         _filter = new UIFilter();
         if(_pos == 6)
         {
            _addItemImage.visible = false;
            _upGradeBtn.visible = false;
         }
         _iconView.tipStyle = "yishi.view.tips.OneLineTip";
         _iconView.tipDirctions = "1,2";
         _iconView.tipGapV = 50;
         _iconView.tipGapH = 0;
         _upGradeBtn.tipData = LanguageMgr.GetTranslation("ancientartifact.resonateUpGrade.tipdata");
         _selectBtn.tipData = LanguageMgr.GetTranslation("AncientResonateItem.selectBtn.tipdata");
      }
      
      private function initEvent() : void
      {
         _upGradeBtn.addEventListener("click",__openUpGradeClick);
         _selectBtn.addEventListener("click",__checklistHandler);
         _selectBtn.addEventListener("mouseDown",__checklistDownHandler);
         _iconView.addEventListener("click",__checklistHandler);
         _iconView.addEventListener("mouseDown",__checklistDownHandler);
      }
      
      private function __checklistDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __checklistHandler(param1:MouseEvent) : void
      {
         var _loc3_:AncientArtifactInfo = model.getArtifactInfoById(AncientArtifactManager.instance.selectTempId);
         if(!_loc3_)
         {
            return;
         }
         if(_checkListView)
         {
            _checkListView.dispose();
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_checkListView)
         {
            _checkListView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AcnientCheckList",[AncientArtifactManager.instance.selectTempId,_pos]);
         }
         _checkListView.addEventListener("dispose",__onSortListDispose);
         var _loc2_:Point = new Point(_addItemImage.x,_addItemImage.y);
         _checkListView.x = localToGlobal(_loc2_).x - 8;
         _checkListView.y = localToGlobal(_loc2_).y + 60;
         LayerManager.Instance.addToLayer(_checkListView,7);
      }
      
      private function __onSortListDispose(param1:Event) : void
      {
         _checkListView.removeEventListener("dispose",__onSortListDispose);
         _checkListView = null;
      }
      
      private function __openUpGradeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_data)
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTips03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("ancientartifact",3,_data);
      }
      
      private function removeEvent() : void
      {
         if(_upGradeBtn)
         {
            _upGradeBtn.removeEventListener("click",__openUpGradeClick);
         }
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__checklistHandler);
         }
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("mouseDown",__checklistDownHandler);
         }
         if(_iconView)
         {
            _iconView.removeEventListener("click",__checklistHandler);
         }
         if(_iconView)
         {
            _iconView.removeEventListener("mouseDown",__checklistDownHandler);
         }
      }
      
      private function initInfo() : void
      {
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc5_:AncientArtifactInfo = null;
         var _loc1_:ArtifactTemplateInfo = null;
         var _loc3_:Number = NaN;
         var _loc2_:String = null;
         _data = model.getResonateInfoByPos(_pos);
         if(_data)
         {
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_data.posGrades,137);
         }
         _iconView.tipData = null;
         if(_anctientId <= 0)
         {
            _iconView.icon = null;
            _tipsTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateAddTips0" + _pos,0);
         }
         else
         {
            _loc5_ = model.getArtifactInfoById(_anctientId);
            if(_loc5_)
            {
               _loc1_ = TempleteManager.instance.artifactTemplateCate.getTemplateById(_loc5_.templateId);
               _iconView.icon = IconFactory.getCommonIconPath(_loc1_.Icon);
               _loc3_ = _loc5_.addPer / 100;
               if(_pos == 1)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt01",Math.floor(_loc5_.attack * _loc4_.ActiveObject / 100 * _loc3_));
                  _loc2_ += "\n" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt03",Math.floor(_loc5_.magicAttack * _loc4_.ActiveObject / 100 * _loc3_));
               }
               else if(_pos == 2)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt02",Math.floor(_loc5_.defences * _loc4_.ActiveObject / 100 * _loc3_));
                  _loc2_ += "\n" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt04",Math.floor(_loc5_.magicDefences * _loc4_.ActiveObject / 100 * _loc3_));
               }
               else if(_pos == 3)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt06",Math.floor(_loc5_.parry * _loc4_.ActiveObject / 100 * _loc3_));
               }
               else if(_pos == 4)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt05",Math.floor(_loc5_.penetrate * _loc4_.ActiveObject / 100 * _loc3_));
               }
               else if(_pos == 5)
               {
                  _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt07",Math.floor(_loc5_.live * _loc4_.ActiveObject / 100 * _loc3_));
               }
               _iconView.tipData = _loc2_;
            }
            else
            {
               _iconView.icon = null;
            }
         }
         if(!_data)
         {
            _tipsTxt.text = "";
            return;
         }
         _tipsTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateAddTips0" + _pos,_loc4_.ActiveObject);
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function setNormalFilter() : void
      {
         _filter.setNormalFilter(this);
      }
      
      public function setGrayFilter() : void
      {
         _filter.setGrayFilter(this);
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function get anctientId() : int
      {
         return _anctientId;
      }
      
      public function set anctientId(param1:int) : void
      {
         _anctientId = param1;
         initInfo();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_upGradeBtn);
         _upGradeBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_addItemImage);
         _addItemImage = null;
         ObjectUtils.disposeObject(_checkListView);
         _checkListView = null;
         super.dispose();
      }
   }
}

