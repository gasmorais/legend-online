package theseusgodhead.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadModel;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusSlateAssetHelper;
   import theseusgodhead.mediator.TheseusBagCellDropMediator;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   
   public class TheseusGodheadBagItem extends Sprite
   {
      
      private static const DRAG_THRESHOLD:int = 5;
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _stoneIcon:Bitmap;
      
      protected var _TheseusGodHeadbagselect:Bitmap;
      
      protected var _godheadbaglvtxt:FilterFrameText;
      
      protected var _godheadbagnametxt:FilterFrameText;
      
      private var _data:TheseusGodheadStoneInfo;
      
      private var _selected:Boolean = false;
      
      private var _colorMatrix:Array;
      
      private var _colorFilter:ColorMatrixFilter;
      
      private var _starContaint:VBox;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _filter:IFilterFormat;
      
      public var isNeedMediator:Boolean;
      
      private var _inDecomposeList:Boolean = false;
      
      private var _lockIcon:DisplayObject;
      
      private var _tipComponent:TransformableComponent;
      
      private var _isMouseDown:Boolean = false;
      
      private var _mouseDownX:Number = 0;
      
      private var _mouseDownY:Number = 0;
      
      private var _isRigist:Boolean;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseusgodhead.UI.TheseusGodheadBagItem";
      
      public var bagPos:int = -1;
      
      public function TheseusGodheadBagItem()
      {
         super();
         initView();
         buttonMode = true;
         selected = false;
         _filter = new UIFilter();
         _colorMatrix = [0.27,0.531,0.099,0,0,0.27,0.531,0.099,0,0,0.27,0.531,0.099,0,0,0,0,0,1,0];
         _colorFilter = new ColorMatrixFilter(_colorMatrix);
         isNeedMediator = true;
         addEventListener("mouseDown",__mouseDown);
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.ItemBack");
         _bg.width = 107;
         _bg.height = 100;
         addChild(_bg);
         _TheseusGodHeadbagselect = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbagselect");
         _godheadbaglvtxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbaglvtxt");
         _godheadbagnametxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadbagnametxt");
         _starContaint = ComponentFactory.Instance.creatComponentByStylename("ui.theseuscollection.StarVbox");
         addChild(_godheadbaglvtxt);
         addChild(_godheadbagnametxt);
         addChild(_starContaint);
         _tipComponent = new TransformableComponent();
         _tipComponent.x = 0;
         _tipComponent.y = 0;
         _tipComponent.tipStyle = "yishi.view.tips.TheseusGodheadEquipTip";
         _tipComponent.graphics.beginFill(0,0);
         _tipComponent.graphics.drawRect(0,0,this.width,this.height);
         _tipComponent.graphics.endFill();
         _tipComponent.mouseEnabled = true;
         addChild(_tipComponent);
      }
      
      public function showVpLock() : void
      {
         if(_lockIcon == null)
         {
            _lockIcon = ComponentFactory.Instance.creat("asset.common.vp.icon");
            addChild(_lockIcon);
         }
         _lockIcon.visible = true;
      }
      
      public function hideVpLock() : void
      {
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      private function showStar(param1:int, param2:VBox) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = (param1 - 1) / 5 + 1;
         ObjectUtils.disposeAllChildren(param2);
         param2.beginChanges();
         var _loc5_:int = _loc7_ * 5;
         var _loc8_:int = (_loc7_ - 1) * 5;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc4_ = _loc8_ + _loc6_;
            if(param1 > _loc4_ && _loc7_ > 0)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.theseus.warStar3");
               param2.addChild(_loc3_);
            }
            _loc6_++;
         }
         param2.commitChanges();
      }
      
      public function set data(param1:TheseusGodheadStoneInfo) : void
      {
         _data = param1;
         _starContaint.visible = false;
         if(!_data)
         {
            _godheadbaglvtxt.text = "";
            _godheadbagnametxt.text = "";
            if(_stoneIcon)
            {
               removeChild(_stoneIcon);
               _stoneIcon = null;
            }
            return;
         }
         if(_tipComponent)
         {
            _tipComponent.tipData = param1;
         }
         if(_data.isLock)
         {
            showVpLock();
         }
         else if(!_data.isLock)
         {
            hideVpLock();
         }
         _godheadbaglvtxt.text = LanguageMgr.GetTranslation("theseusgodhead.txt7",_data.level);
         _godheadbagnametxt.text = _data.name;
         if(_data.star >= 0)
         {
            _starContaint.visible = true;
            showStar(_data.star,_starContaint);
         }
         updateStoneIcon();
         if(!_isRigist)
         {
            registerMediator();
         }
      }
      
      public function setDragStatus(param1:Boolean) : void
      {
         if(param1)
         {
            _stoneIcon.scaleX = 1;
            _stoneIcon.scaleY = 1;
            if(_tipComponent)
            {
               _tipComponent.visible = false;
            }
            _godheadbaglvtxt.visible = false;
            _bg.visible = false;
            _godheadbagnametxt.visible = false;
            if(_starContaint)
            {
               _starContaint.visible = false;
            }
            this.mouseEnabled = false;
         }
         else
         {
            this.mouseEnabled = true;
            _stoneIcon.scaleX = 0.3;
            _stoneIcon.scaleY = 0.3;
            _godheadbaglvtxt.visible = true;
            _bg.visible = true;
            _godheadbagnametxt.visible = true;
            if(_starContaint)
            {
               _starContaint.visible = true;
            }
            if(_tipComponent)
            {
               _tipComponent.visible = true;
            }
         }
      }
      
      private function updateStoneIcon() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(_stoneIcon)
         {
            _stoneIcon = null;
         }
         if(_data && _data.shape > 0)
         {
            _stoneIcon = TheseusSlateAssetHelper.getSlateDisplay(_data.shape,_data.rotate);
            if(_stoneIcon)
            {
               _loc3_ = _stoneIcon.width;
               _loc1_ = _stoneIcon.height;
               _stoneIcon.scaleX = 0.3;
               _stoneIcon.scaleY = 0.3;
               _stoneIcon.x = 45 - _loc3_ * 0.3 / 2;
               _stoneIcon.y = 45 - _loc1_ * 0.3 / 2;
               addChildAt(_stoneIcon,1);
               addChild(_tipComponent);
               _loc2_ = int(model.DecomposeList.indexOf(_data.stoneId));
               if(_loc2_ == -1)
               {
                  setNormalFilter();
               }
               else
               {
                  setGrayFilter();
               }
            }
         }
      }
      
      public function get data() : TheseusGodheadStoneInfo
      {
         return _data;
      }
      
      public function set inDecomposeList(param1:Boolean) : void
      {
         _inDecomposeList = param1;
         if(param1)
         {
            setGrayFilter();
         }
         else
         {
            setNormalFilter();
         }
      }
      
      public function get inDecomposeList() : Boolean
      {
         return _inDecomposeList;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_TheseusGodHeadbagselect)
         {
            _TheseusGodHeadbagselect.visible = param1;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set level(param1:int) : void
      {
         if(_godheadbaglvtxt)
         {
            _godheadbaglvtxt.text = "Lv." + param1;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("mouseDown",__mouseDown);
         if(stage)
         {
            stage.removeEventListener("mouseMove",__mouseMove);
            stage.removeEventListener("mouseUp",__mouseUp);
         }
         _isMouseDown = false;
         unregisterMediator();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_stoneIcon);
         _stoneIcon = null;
         ObjectUtils.disposeObject(_TheseusGodHeadbagselect);
         _TheseusGodHeadbagselect = null;
         ObjectUtils.disposeObject(_godheadbaglvtxt);
         _godheadbaglvtxt = null;
         ObjectUtils.disposeObject(_godheadbagnametxt);
         _godheadbagnametxt = null;
         ObjectUtils.disposeObject(_starContaint);
         _starContaint = null;
         ObjectUtils.disposeObject(_tipComponent);
         _tipComponent = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _isMouseDown = true;
         _mouseDownX = param1.stageX;
         _mouseDownY = param1.stageY;
         stage.addEventListener("mouseMove",__mouseMove);
         stage.addEventListener("mouseUp",__mouseUp);
      }
      
      private function __mouseMove(param1:MouseEvent) : void
      {
         if(!_isMouseDown || !_data)
         {
            return;
         }
         var _loc2_:Number = Math.abs(param1.stageX - _mouseDownX);
         var _loc3_:Number = Math.abs(param1.stageY - _mouseDownY);
         if(_loc2_ > 5 || _loc3_ > 5)
         {
            _isMouseDown = false;
            stage.removeEventListener("mouseMove",__mouseMove);
            stage.removeEventListener("mouseUp",__mouseUp);
            if(model.canDragStone())
            {
               startDragOperation(param1.stageX,param1.stageY);
            }
            else
            {
               dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
         _isMouseDown = false;
         stage.removeEventListener("mouseMove",__mouseMove);
         stage.removeEventListener("mouseUp",__mouseUp);
      }
      
      public function get model() : TheseusGodheadModel
      {
         return TheseussoulManager.Instance.modelGodhead;
      }
      
      private function startDragOperation(param1:Number, param2:Number) : void
      {
         if(!model.canDragStone())
         {
            return;
         }
         var _loc3_:Object = {
            "stoneInfo":_data,
            "mouseX":param1,
            "mouseY":param2,
            "bagPos":this.bagPos
         };
         var _loc4_:NotificationEvent = new NotificationEvent("dragStart",_loc3_,true,true);
         dispatchEvent(_loc4_);
      }
      
      public function setGrayFilter() : void
      {
         this.filters = [_colorFilter];
         isNormalFilter = false;
      }
      
      public function setNormalFilter() : void
      {
         this.filters = null;
         isNormalFilter = true;
      }
      
      protected function registerMediator() : void
      {
         _isRigist = true;
         var _loc1_:Array = [TheseusBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseusgodhead.UI.TheseusGodheadBagItem");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
   }
}

