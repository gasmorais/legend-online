package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.DragonTalkerManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerSkillItemView extends Component
   {
      
      private var _effectBack:ScaleFrameImage;
      
      private var _skillBack:ScaleFrameImage;
      
      private var _shadowBack:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _levelback:ScaleFrameImage;
      
      private var _levelBackShape:ScaleFrameImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _passitive:Bitmap;
      
      private var _superSkill:Bitmap;
      
      private var _addBtn:BaseButton;
      
      private var _data:SkillInfo;
      
      private var _filter:IFilterFormat;
      
      private var _isOpen:Boolean;
      
      private var _canAdd:Boolean;
      
      private var _isDisable:Boolean;
      
      public function DragonTalkerSkillItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillEffectBack");
         _shadowBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillItemShadowBack");
         _skillBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("DragonTalkerSkillItemView.NewSkillIcon");
         _levelBackShape = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewLevelBackShape");
         _levelback = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillLevelBack");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillLevelTxt");
         _passitive = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.NewPassitive");
         _superSkill = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.NewSuperSkill");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillAddBtn");
         addChild(_shadowBack);
         addChild(_skillBack);
         addChild(_icon);
         addChild(_levelBackShape);
         addChild(_levelback);
         addChild(_levelTxt);
         addChild(_passitive);
         addChild(_superSkill);
         addChild(_effectBack);
         _effectBack.mouseChildren = false;
         _effectBack.mouseEnabled = false;
         _effectBack.setFrame(4);
         addChild(_addBtn);
         _addBtn.doubleClickEnabled = false;
         _filter = new UIFilter();
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _icon.addEventListener("mouseDown",__clickHandler);
         _addBtn.addEventListener("click",__addHandler);
         _addBtn.addEventListener("mouseOver",__addBtnOverHandler);
         _addBtn.addEventListener("mouseDown",__addBtnOverHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         if(_icon != null)
         {
            _icon.removeEventListener("mouseDown",__clickHandler);
         }
         if(_addBtn != null)
         {
            _addBtn.removeEventListener("click",__addHandler);
            _addBtn.removeEventListener("mouseOver",__addBtnOverHandler);
            _addBtn.removeEventListener("mouseDown",__addBtnOverHandler);
         }
      }
      
      private function __addBtnOverHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_canAdd)
         {
            return;
         }
         if(_data.grade == 0)
         {
            _effectBack.setFrame(3);
         }
         else if(_levelTxt.text.length > 3)
         {
            _effectBack.setFrame(2);
         }
         else
         {
            _effectBack.setFrame(1);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _effectBack.setFrame(4);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         if(_data.templateInfo.UseWay == 2)
         {
            return;
         }
         if(!_data || _data.grade == 0)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [DragonTalkerFastSkillItem,Frame,stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(_icon.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:DragonTalkerFastSkillItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is DragonTalkerFastSkillItem)
            {
               _loc2_ = param1.dropTarget as DragonTalkerFastSkillItem;
               _loc2_.data = _data;
               _loc2_.refreshView();
               MsgMan.notifyObserver("SET_FAST_KEY");
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      protected function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _levelTxt.text = _data.grade + "/" + model.getSkillMaxGrade(_data);
         _icon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icons);
         _passitive.visible = _data.templateInfo.UseWay == 2;
         _superSkill.visible = SkillPriorityType.isSuperSkill(_data.templateInfo.Priority);
         checkState();
         checkCondition();
         _icon.tipData = _data;
      }
      
      public function checkCondition() : void
      {
         if(!_data)
         {
            return;
         }
         _isOpen = false;
         _levelback.visible = true;
         _levelTxt.visible = true;
         _levelBackShape.visible = true;
         _filter.setNormalFilter(_skillBack);
         _canAdd = false;
         if(_data.grade == 0)
         {
            _isOpen = true;
            _levelback.visible = false;
            _levelTxt.visible = false;
            _levelBackShape.visible = false;
            _filter.setGrayFilter(_skillBack);
         }
         if(checkCanAdd())
         {
            _filter.setNormalFilter(_icon);
            _filter.setNormalFilter(_passitive);
            _filter.setNormalFilter(_superSkill);
            _addBtn.visible = true;
            _canAdd = true;
         }
         else
         {
            _filter.setGrayFilter(_icon);
            _filter.setGrayFilter(_passitive);
            _filter.setGrayFilter(_superSkill);
            _addBtn.visible = false;
         }
         if(_data.grade > 0)
         {
            _filter.setNormalFilter(_icon);
            _filter.setNormalFilter(_passitive);
            _filter.setNormalFilter(_superSkill);
            _canAdd = true;
         }
      }
      
      public function setDisabled() : void
      {
         _isDisable = true;
         if(_data)
         {
            _data.grade = 0;
         }
         refreshView();
         _filter.setGrayFilter(_icon);
         _filter.setGrayFilter(_passitive);
         _filter.setGrayFilter(_superSkill);
         _addBtn.visible = false;
      }
      
      public function getDisabled() : Boolean
      {
         return _isDisable;
      }
      
      private function checkCanAdd() : Boolean
      {
         if(!_data.nextTemplateInfo)
         {
            return false;
         }
         var _loc1_:DragonTalkerSkillInfo = model.getSkillInfoByIndex(model.skillTabIndex);
         if(!_loc1_)
         {
            return false;
         }
         if(_loc1_.skillPoint <= 0)
         {
            return false;
         }
         if(_data.checkUpgradeCondition(_data.nextTemplateInfo).length > 0)
         {
            return false;
         }
         return true;
      }
      
      public function set data(param1:SkillInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            visible = false;
            return;
         }
         refreshView();
      }
      
      public function get data() : SkillInfo
      {
         return _data;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      private function checkState() : void
      {
         if(_levelTxt.text.length > 3)
         {
            _levelback.setFrame(2);
            _levelBackShape.setFrame(thane.templateInfo.Job * 2);
            _shadowBack.setFrame(thane.templateInfo.Job);
         }
         else
         {
            _levelback.setFrame(1);
            _levelBackShape.setFrame(thane.templateInfo.Job * 2 - 1);
            _shadowBack.setFrame(thane.templateInfo.Job);
         }
      }
      
      public function get addbtn() : BaseButton
      {
         return _addBtn;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_shadowBack);
         _shadowBack = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_levelback);
         _levelback = null;
         ObjectUtils.disposeObject(_levelBackShape);
         _levelBackShape = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_passitive);
         _passitive = null;
         ObjectUtils.disposeObject(_superSkill);
         _superSkill = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         _filter = null;
         super.dispose();
      }
   }
}

