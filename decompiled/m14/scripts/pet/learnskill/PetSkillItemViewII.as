package pet.learnskill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetSkillItemViewII extends Component
   {
      
      private var _back:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _tipIcon:ScaleFrameImage;
      
      private var _indexBack:Bitmap;
      
      private var _indexTxt:FilterFrameText;
      
      private var _quitBtn:TextButton;
      
      private var _lockImg:Bitmap;
      
      private var _isLock:Boolean;
      
      private var _index:int;
      
      protected var _filter:IFilterFormat;
      
      public var skillEnable:Boolean = true;
      
      private var _data:SkillTempInfo;
      
      private var _skillType:int;
      
      public function PetSkillItemViewII()
      {
         super();
         _filter = new UIFilter();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("petskill.SkillBack");
         _indexBack = ComponentFactory.Instance.creatBitmap("asset.pet.FastKeyItemIndex");
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("petSkill.FastKeyItemIndexTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("petSkill.SkillIcon");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("petskill.SkillIconBack");
         _quitBtn = ComponentFactory.Instance.creatComponentByStylename("pet.quitBtn");
         _lockImg = ComponentFactory.Instance.creat("asset.pet.ItemLock");
         _lockImg.x = _lockImg.y = 1;
         _lockImg.visible = false;
         _tipIcon.mouseEnabled = false;
         _back.mouseEnabled = false;
         _indexBack.visible = false;
         _indexTxt.visible = false;
         _quitBtn.text = LanguageMgr.GetTranslation("pet.PetSkillItemViewII.quitText");
         _quitBtn.visible = false;
         addChild(_back);
         addChild(_icon);
         addChild(_tipIcon);
         addChild(_quitBtn);
         addChild(_lockImg);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
         ObjectUtils.disposeObject(_indexBack);
         _indexBack = null;
         ObjectUtils.disposeObject(_indexTxt);
         _indexTxt = null;
         ObjectUtils.disposeObject(_quitBtn);
         _quitBtn = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc2_:String = null;
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(_data)
         {
            if(skillEnable)
            {
               addEvent();
            }
            if(_data.UseWay == 2)
            {
               _tipIcon.visible = true;
            }
            else
            {
               _tipIcon.visible = false;
            }
            _icon.visible = true;
            _loc2_ = IconFactory.getCommonIconPath(_data.Icons);
            if(_icon.icon != _loc2_)
            {
               _icon.icon = _loc2_;
            }
            _icon.tipData = _data;
            _quitBtn.visible = true;
         }
         else
         {
            removeEvent();
            _tipIcon.visible = true;
            _icon.icon = null;
            _icon.visible = false;
            _icon.tipData = null;
            _quitBtn.visible = false;
         }
         this.skillType = skillType;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         var _loc2_:int = _index + 1;
         _indexTxt.text = _loc2_.toString();
         _indexBack.visible = true;
         _indexTxt.visible = true;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function addEvent() : void
      {
         _icon.addEventListener("mouseDown",__clickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         _quitBtn.addEventListener("click",__clickQuitHandler);
      }
      
      private function removeEvent() : void
      {
         if(_icon)
         {
            _icon.removeEventListener("mouseDown",__clickHandler);
         }
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         if(_quitBtn)
         {
            _quitBtn.removeEventListener("click",__clickQuitHandler);
         }
      }
      
      private function __clickQuitHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("QUIT_PET_SKILL",data.TemplateId);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(!canSwap)
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
         _loc2_.dropChecks = [PetSkillItemViewII];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:PetSkillItemViewII = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is PetSkillItemViewII)
            {
               _loc2_ = param1.dropTarget as PetSkillItemViewII;
               swap(this,_loc2_);
               NotificationManager.instance.sendNotification("PET_SKILL_CHANGE",null);
            }
         }
         ObjectUtils.disposeObject(param1.dragIcon);
         param1.stopImmediatePropagation();
      }
      
      private function swap(param1:PetSkillItemViewII, param2:PetSkillItemViewII) : void
      {
         var _loc3_:SkillTempInfo = param2.data;
         if(!param2.canSwap)
         {
            return;
         }
         param2.data = param1.data;
         param1.data = _loc3_;
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_filter)
         {
            _filter.setLightingFilter(this);
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_filter)
         {
            _filter.setNormalFilter(this);
         }
      }
      
      public function get canSwap() : Boolean
      {
         if(isLock || skillType == 2)
         {
            return false;
         }
         return true;
      }
      
      public function get skillType() : int
      {
         return _skillType;
      }
      
      public function set skillType(param1:int) : void
      {
         _skillType = param1;
         if(_skillType == 1)
         {
            _back.setFrame(1);
            _tipIcon.setFrame(1);
         }
         else
         {
            _back.setFrame(2);
            if(!_data)
            {
               _tipIcon.setFrame(2);
            }
            else
            {
               _tipIcon.setFrame(3);
            }
         }
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         _lockImg.visible = _isLock;
      }
      
      public function setQuitBtnDisappear() : void
      {
         _quitBtn.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         _filter = null;
         super.dispose();
         _data = null;
      }
   }
}

