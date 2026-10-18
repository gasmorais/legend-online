package stararea
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class StarareaLeftView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _Lbg2:MutipleImage;
      
      private var _imgLLine:MutipleImage;
      
      private var _bit1:Bitmap;
      
      private var _btnOut:BaseButton;
      
      private var _btnIn:BaseButton;
      
      private var arrItem:Array;
      
      public function StarareaLeftView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         _btnIn.addEventListener("click",onClickIn);
         _btnOut.addEventListener("click",onClickOut);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         _btnIn.removeEventListener("click",onClickIn);
         _btnOut.removeEventListener("click",onClickOut);
      }
      
      private function onClickOut(param1:MouseEvent) : void
      {
         this.x = 0;
         _btnOut.visible = false;
         _btnIn.visible = true;
      }
      
      private function onClickIn(param1:MouseEvent) : void
      {
         this.x = -215;
         _btnOut.visible = true;
         _btnIn.visible = false;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:StarareaLeftViewItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.left.bg");
         _Lbg2 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.Lbg2");
         _imgLLine = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.imgLLine");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.stararea.str6");
         _btnOut = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.left.btnOut");
         _btnIn = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.left.btnIn");
         addChild(_bg);
         addChild(_Lbg2);
         addChild(_imgLLine);
         addChild(_bit1);
         addChild(_btnOut);
         addChild(_btnIn);
         _btnOut.visible = false;
         arrItem = [];
         var _loc2_:Array = [0,1,2,4,5,6,3,7,8];
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _loc3_ = int(_loc2_[_loc4_]);
            _loc1_ = new StarareaLeftViewItem(_loc3_ + 1);
            addChild(_loc1_);
            _loc1_.x = 8;
            _loc1_.y = 40 + _loc4_ * 55;
            arrItem.push(_loc1_);
            _loc4_++;
         }
         LayerManager.Instance.addToLayer(this,4);
         resizeHandler();
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = 0;
         this.y = (StageReferance.stage.stageHeight - 543) * 0.5;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:StarareaLeftViewItem = null;
         removeEvent();
         _loc2_ = 0;
         while(_loc2_ < arrItem.length)
         {
            _loc1_ = arrItem[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            _loc2_++;
         }
         arrItem = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_Lbg2);
         _Lbg2 = null;
         ObjectUtils.disposeObject(_imgLLine);
         _imgLLine = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_btnOut);
         _btnOut = null;
         ObjectUtils.disposeObject(_btnIn);
         _btnIn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

