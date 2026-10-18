package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import mvc.module.gloryroad.GloryRoadMirrorInfo;
   
   public class GloryRoadRivalTip extends BaseTip
   {
      
      private var _bmps:Array;
      
      private var _txts:Array;
      
      private var _mutiBg02:MutipleImage;
      
      public function GloryRoadRivalTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc1_:DisplayObject = null;
         _mutiBg02 = ComponentFactory.Instance.creatComponentByStylename("gloryroad.attribute.line");
         addChild(_mutiBg02);
         var _loc2_:int = 10;
         _bmps = [];
         _txts = [];
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc4_ = addCompoentToThis("asset.gloryroad.attImg" + _loc3_,true);
            _loc4_.x = 10;
            _loc4_.y = _loc2_;
            _loc1_ = addCompoentToThis("gloryroad.attribute.attTxt",false);
            _loc1_.x = 110;
            _loc1_.y = _loc2_;
            _loc2_ += 20;
            if(_loc3_ == 6)
            {
               _loc2_ += 10;
            }
            _loc3_++;
         }
      }
      
      private function addCompoentToThis(param1:String, param2:Boolean) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         if(param2)
         {
            _loc3_ = new Bitmap(ClassUtils.CreatInstance(param1));
            _bmps.push(_loc3_);
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("gloryroad.attribute.attTxt");
            _txts.push(_loc3_);
         }
         this.addChild(_loc3_);
         return _loc3_;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:GloryRoadMirrorInfo = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(tipData)
         {
            _loc1_ = tipData as GloryRoadMirrorInfo;
            _loc3_ = _loc1_.getAttValues();
            _loc4_ = 0;
            _loc2_ = int(_loc3_.length);
            while(_loc4_ < _loc2_)
            {
               FilterFrameText(_txts[_loc4_]).text = _loc3_[_loc4_];
               _loc4_++;
            }
            _bg.width = 200;
            _bg.height = 266;
         }
      }
   }
}

