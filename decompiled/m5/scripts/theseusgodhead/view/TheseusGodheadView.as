package theseusgodhead.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusGodheadModel;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import theseusgodhead.UI.TheseusGodgrid;
   import theseusgodhead.UI.TheseusGodheadStoneUI;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class TheseusGodheadView extends Sprite
   {
      
      public static const DRAG_START:String = "dragStart";
      
      public static const DRAG_END:String = "dragEnd";
      
      public static const DRAG_DROP:String = "dragDrop";
      
      public static const DRAG_DROP_TO_BAG:String = "dragDropToBag";
      
      public static const GRID_SELECTED:String = "gridSelected";
      
      public static const REGRESH_GRID:String = "refreshGRID";
      
      public static const STONEUI_MOUSENABLECHANGE:String = "STONEUI_MOUSENABLECHANGE";
      
      protected var _TheseusGodHeadbg:Bitmap;
      
      protected var _godheadViewDesc:FilterFrameText;
      
      protected var _godheadEquippedTxt:FilterFrameText;
      
      protected var _infoBtn:BaseButton;
      
      private var _gridContainer:Sprite;
      
      private var _grids:Array;
      
      private var _stoneContainer:Sprite;
      
      private var _stoneUIs:Vector.<TheseusGodheadStoneUI>;
      
      private var _highlightGrids:Array = [];
      
      private var _draggingStoneInfo:TheseusGodheadStoneInfo;
      
      private var _draggingStoneGridPos:int = -1;
      
      private var _draggingStoneUI:Sprite;
      
      private var _dragContainer:Sprite;
      
      private var _isDragging:Boolean = false;
      
      public function TheseusGodheadView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function get godheadmodel() : TheseusGodheadModel
      {
         return TheseussoulManager.Instance.modelGodhead;
      }
      
      private function refreshGrids() : void
      {
         var _loc3_:int = 0;
         var _loc5_:TheseusGodheadStoneUI = null;
         var _loc4_:TheseusGodheadStoneInfo = null;
         var _loc6_:TheseusGodgrid = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!_grids)
         {
            return;
         }
         clearStoneContainer();
         var _loc1_:Array = godheadmodel.getEquipedStoneInfo();
         var _loc7_:int = int(_loc1_.length);
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_ = _loc1_[_loc8_];
            if(_loc4_)
            {
               _loc3_ = int(_loc4_.equipPos);
               if(_loc3_ != -1)
               {
                  if(_loc3_ < _grids.length)
                  {
                     _loc6_ = _grids[_loc3_];
                     _loc5_ = new TheseusGodheadStoneUI();
                     _loc5_.setStoneData(_loc4_,_loc3_);
                     _loc5_.x = _loc6_.x - 22;
                     _loc5_.y = _loc6_.y - 20;
                     _loc5_.mouseEnabled = true;
                     _stoneContainer.addChild(_loc5_);
                     _stoneUIs.push(_loc5_);
                  }
               }
            }
            _loc8_++;
         }
         var _loc2_:int = int(_grids.length);
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            _loc6_ = _grids[_loc8_];
            _loc6_.unlocked = godheadmodel.isGridUnlocked(_loc6_.pos);
            if(!_loc6_.unlocked)
            {
               _loc6_.addEventListener("click",__gridMouseDown);
               addChild(_loc6_);
            }
            else
            {
               _loc9_ = this.getChildIndex(_stoneContainer);
               addChildAt(_loc6_,_loc9_ - 1);
            }
            _loc8_++;
         }
         updateEquippedText();
      }
      
      private function updateEquippedText() : void
      {
         var _loc9_:TheseusGodheadStoneInfo = null;
         var _loc13_:Array = null;
         var _loc15_:Array = null;
         var _loc11_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc16_:String = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         if(!_godheadEquippedTxt)
         {
            return;
         }
         var _loc8_:int = 0;
         var _loc10_:Array = [];
         var _loc12_:Array = godheadmodel.getEquipedStoneInfo();
         var _loc14_:int = int(_loc12_.length);
         if(_loc14_ == 0)
         {
            _godheadEquippedTxt.text = "";
         }
         else
         {
            _loc13_ = [];
            _loc15_ = [];
            _loc11_ = "";
            _loc4_ = 1;
            _loc5_ = 0;
            while(_loc5_ < _loc14_)
            {
               _loc9_ = _loc12_[_loc5_];
               if(_loc9_)
               {
                  if(_loc9_.equipPos != -1)
                  {
                     _loc1_ = int(_loc9_.SlateType);
                     _loc11_ = godheadmodel.getNamebySlateType(_loc1_);
                     _loc6_ = _loc13_.indexOf(_loc11_);
                     if(_loc6_ == -1)
                     {
                        _loc13_.push(_loc11_);
                        _loc15_.push(1);
                     }
                     else
                     {
                        _loc4_ = int(_loc15_[_loc6_]);
                        _loc15_[_loc6_] = _loc4_ + 1;
                     }
                  }
               }
               _loc5_++;
            }
            _loc16_ = "";
            _loc3_ = int(_loc13_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc16_ += _loc13_[_loc7_] + "x" + _loc15_[_loc7_] + "  ";
               _loc2_ = (_loc7_ + 1) % 2;
               if(_loc2_ == 0 && _loc7_ != 0)
               {
                  _loc16_ += "\n";
               }
               _loc7_++;
            }
            _godheadEquippedTxt.text = _loc16_;
         }
      }
      
      protected function initView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 5;
         var _loc2_:int = 0;
         _loc2_ = 60;
         var _loc3_:int = 0;
         _loc3_ = 0;
         var _loc5_:int = 0;
         var _loc4_:TheseusGodgrid = null;
         _TheseusGodHeadbg = ComponentFactory.Instance.creatBitmap("TheseusGodHeadbg");
         _godheadViewDesc = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadViewDesc");
         _godheadEquippedTxt = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.godheadEquippedTxt");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.infoBtn");
         _infoBtn.x = 266;
         addChild(_godheadViewDesc);
         addChild(_godheadEquippedTxt);
         addChild(_infoBtn);
         _godheadViewDesc.text = LanguageMgr.GetTranslation("theseusgodhead.txt5");
         _godheadEquippedTxt.text = "";
         _gridContainer = new Sprite();
         _gridContainer.x = 30;
         _gridContainer.y = 20;
         _grids = [];
         _loc5_ = 0;
         while(_loc5_ < 25)
         {
            _loc4_ = new TheseusGodgrid();
            _loc4_.pos = _loc5_;
            _loc4_.x = _loc5_ % 5 * (60 + 0) + 30;
            _loc4_.y = int(_loc5_ / 5) * (60 + 0) + 20;
            addChild(_loc4_);
            _grids.push(_loc4_);
            _loc5_++;
         }
         _stoneContainer = new Sprite();
         _stoneContainer.x = 20;
         _stoneContainer.y = 20;
         _stoneContainer.mouseEnabled = true;
         addChild(_stoneContainer);
         _stoneUIs = new Vector.<TheseusGodheadStoneUI>();
         refreshGrids();
      }
      
      private function __gridMouseDown(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:TheseusGodgrid = param1.currentTarget as TheseusGodgrid;
         if(!_loc4_)
         {
            return;
         }
         if(!_loc4_.unlocked)
         {
            _loc5_ = _loc4_.pos;
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("theseusgodhead.equipped_none.txt1");
            SimpleAlertHelper.instance.data = [buyCallBack,_loc5_];
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_);
            return;
         }
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(!param1)
         {
            return;
         }
         TheseussoulManager.Instance.unlockPos(param3);
      }
      
      private function initEvent() : void
      {
         _infoBtn.addEventListener("click",infoHandler);
         NotificationManager.instance.addEventListener("refreshGRID",refresh);
         NotificationManager.instance.addEventListener("STONEUI_MOUSENABLECHANGE",changeContainer);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("refreshGRID",refresh);
         NotificationManager.instance.removeEventListener("STONEUI_MOUSENABLECHANGE",changeContainer);
         _infoBtn.removeEventListener("click",infoHandler);
      }
      
      private function infoHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseussoul",11);
      }
      
      public function changeContainer(param1:NotificationEvent) : void
      {
         _stoneContainer.mouseEnabled = param1.data;
      }
      
      public function refresh(param1:* = null) : void
      {
         refreshGrids();
      }
      
      private function clearStoneContainer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TheseusGodheadStoneUI = null;
         if(_stoneUIs)
         {
            _loc1_ = int(_stoneUIs.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = _stoneUIs[_loc2_];
               if(_loc3_)
               {
                  if(_loc3_.parent)
                  {
                     _loc3_.parent.removeChild(_loc3_);
                  }
                  _loc3_.dispose();
               }
               _loc2_++;
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:TheseusGodgrid = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_TheseusGodHeadbg);
         _TheseusGodHeadbg = null;
         ObjectUtils.disposeObject(_godheadViewDesc);
         _godheadViewDesc = null;
         ObjectUtils.disposeObject(_godheadEquippedTxt);
         _godheadEquippedTxt = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_gridContainer);
         _gridContainer = null;
         ObjectUtils.disposeObject(_stoneContainer);
         _stoneContainer = null;
         if(_grids)
         {
            _loc2_ = int(_stoneUIs.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = _grids[_loc3_];
               if(_loc1_)
               {
                  _loc1_.removeEventListener("click",__gridMouseDown);
                  ObjectUtils.disposeObject(_loc1_);
               }
               _loc3_++;
            }
            _grids = null;
         }
         if(_stoneUIs)
         {
            clearStoneContainer();
            _stoneUIs = null;
         }
         if(_draggingStoneUI && _draggingStoneUI.parent)
         {
            _draggingStoneUI.parent.removeChild(_draggingStoneUI);
            _draggingStoneUI = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

