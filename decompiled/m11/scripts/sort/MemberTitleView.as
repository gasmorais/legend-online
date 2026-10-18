package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.controler.SortController;
   import mvc.module.sort.SortModel;
   import yishi.manager.FrameControllerManager;
   
   public class MemberTitleView extends Sprite implements Disposeable
   {
      
      private var _title:ScaleLeftRightImage;
      
      private var _model:SortModel;
      
      private var _controller:SortController;
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _paras:Vector.<FilterFrameText>;
      
      public function MemberTitleView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:Bitmap = null;
         _controller = FrameControllerManager.instance.sortController;
         _model = _controller.model;
         _title = ComponentFactory.Instance.creatComponentByStylename("sort.TitleBg");
         addChild(_title);
         _paras = new Vector.<FilterFrameText>();
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("sort.sortText");
            _paras.push(_loc1_);
            _loc2_++;
         }
         _bitmaps = new Vector.<Bitmap>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.sort.spaceLine");
            _bitmaps.push(_loc3_);
            _loc2_++;
         }
         __onSelectedChangeHandler(null);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bitmaps = null;
         _paras = null;
         _model = null;
         _controller = null;
         _bitmaps = null;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
      }
      
      private function remveEvent() : void
      {
         _model.removeEventListener("SELECTE_CHANGE",__onSelectedChangeHandler);
      }
      
      private function __onSelectedChangeHandler(param1:Event) : void
      {
         removeTxtAndBitmap();
         if(_model.isCross)
         {
            layout("C" + _model.currentSelected);
         }
         else
         {
            layout("" + _model.currentSelected);
         }
      }
      
      private function removeTxtAndBitmap() : void
      {
         for each(var _loc1_:FilterFrameText in _paras)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         for each(var _loc2_:Bitmap in _bitmaps)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      private function layout(param1:String) : void
      {
         var _loc7_:Bitmap = null;
         var _loc6_:int = 0;
         var _loc5_:FilterFrameText = null;
         var _loc11_:String = null;
         var _loc10_:Array = _model.languageConfig[param1];
         var _loc2_:String = _model.widthConfig[param1];
         if(!_loc10_ || !_loc2_)
         {
            return;
         }
         var _loc3_:Array = _loc2_.split(",");
         var _loc9_:int = 0;
         var _loc4_:int = 9;
         for each(var _loc8_:String in _loc3_)
         {
            _loc6_ = parseInt(_loc8_);
            _loc5_ = _paras[_loc9_];
            _loc7_ = _bitmaps[_loc9_];
            _loc11_ = _loc10_[_loc9_];
            _loc5_.text = _loc11_;
            _loc5_.width = _loc6_;
            _loc5_.x = _loc4_;
            _loc4_ += _loc6_;
            _loc7_.x = _loc4_;
            addChild(_loc5_);
            addChild(_loc7_);
            _loc9_++;
         }
         removeChild(_loc7_);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _bitmaps[_loc1_].bitmapData.dispose();
            _loc1_++;
         }
         remveEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

