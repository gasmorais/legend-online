package armyII.viewII.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   
   public class SkillitemView extends Sprite implements Disposeable
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
      
      public function SkillitemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillEffectBack");
         _effectBack.setFrame(4);
         _shadowBack = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillItemShadowBack");
         _skillBack = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("army.skill.NewSkillIcon");
         _levelBackShape = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewLevelBackShape");
         _levelback = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillLevelBack");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillLevelTxt");
         _passitive = ComponentFactory.Instance.creatBitmap("asset.army.NewPassitive");
         _superSkill = ComponentFactory.Instance.creatBitmap("asset.army.NewSuperSkill");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.NewSkillAddBtn");
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
         addChild(_addBtn);
         _addBtn.doubleClickEnabled = false;
         _filter = new UIFilter();
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _icon.addEventListener("mouseDown",__clickHandler);
         _addBtn.addEventListener("click",__addHandler);
         _addBtn.addEventListener("mouseOver",__addBtnOverHandler);
         _addBtn.addEventListener("mouseDown",__addBtnOverHandler);
         NotificationManager.instance.addEventListener("SKILL_UPGRADE",__skillChangeHandler);
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
         NotificationManager.instance.removeEventListener("SKILL_UPGRADE",__skillChangeHandler);
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
         _loc2_.dropChecks = [FastSkillItem,Frame,Stage];
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
         var _loc2_:FastSkillItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is FastSkillItem)
            {
               _loc2_ = param1.dropTarget as FastSkillItem;
               _loc2_.data = _data;
               _loc2_.refreshView();
               NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      protected function __addHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(thane.vocationIndex > 0)
         {
            if(_data.grade > 0 || _data.templateInfo.Index < 3)
            {
               control.sendAddSkillPoint(_data);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("army.skill.change2.addSkill",_data.templateInfo.TemplateName);
               SimpleAlertHelper.instance.data = [__alertResponse];
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
            }
         }
         else
         {
            control.sendAddSkillPoint(_data);
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            control.sendAddSkillPoint(_data);
         }
      }
      
      private function __skillChangeHandler(param1:NotificationEvent) : void
      {
         moveSkill(param1.data);
      }
      
      private function __levelUpdataHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function moveSkill(param1:SkillInfo) : void
      {
         if(!_data)
         {
            return;
         }
         if(param1 != _data)
         {
            return;
         }
         if(_data.grade != 1 || _data.templateInfo.UseWay == 2)
         {
            return;
         }
         if(thane.skillCate.fastKey.indexOf(_data.templateInfo.SonType.toString()) > 0)
         {
            return;
         }
         if(thane.fastKeyLength >= 5)
         {
            return;
         }
         var _loc2_:Point = parent.localToGlobal(new Point(x,y));
         NotificationManager.instance.sendNotification("FAST_KEY_MOVE",{
            "data":_data,
            "point":_loc2_,
            "icon":getDragIconObj()
         });
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _levelTxt.text = _data.grade + "/" + _data.maxGrade;
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
         if(thane.skillCate.skillPoint <= 0)
         {
            return false;
         }
         if(_data.checkUpgradeCondition(_data.nextTemplateInfo).length > 0)
         {
            return false;
         }
         var _loc2_:Array = [421,422,423];
         var _loc1_:int = _loc2_.indexOf(_data.nextTemplateInfo.MasterType);
         if(_loc1_ != -1 && Boolean(thane.skillCate.fourChooseOne(_data.nextTemplateInfo.Index)))
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
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
      }
   }
}

