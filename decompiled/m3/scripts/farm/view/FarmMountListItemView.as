package farm.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mvc.module.mounts.WildSoulInfo;
   import org.bytearray.display.ScaleBitmap;
   import yishi.utils.MountAvatarPathHelper;
   import yishi.view.base.StarBar;
   
   public class FarmMountListItemView extends FarmPetListItemView
   {
      
      protected var _data:WildSoulInfo;
      
      private var _canvas:ScaleBitmap;
      
      private var _starBox:StarBar;
      
      public function FarmMountListItemView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         removeChild(super._lvTxt);
         _canvas = new ScaleBitmap(new BitmapData(1,1,true,0));
         addChild(_canvas);
         _starBox = new StarBar(5,0,"asset.wildsoul.EmptyStar","asset.wildsoul.FullStar");
         _starBox.mouseEnabled = _starBox.mouseChildren = false;
         addChild(_starBox);
         _starBox.x = 65;
         _starBox.y = 31;
      }
      
      public function get mountData() : WildSoulInfo
      {
         return _data;
      }
      
      public function set mountData(param1:WildSoulInfo) : void
      {
         _data = param1;
         if(super._hBox)
         {
            super._hBox.removeAllChild();
         }
         if(_data)
         {
            this.mouseEnabled = true;
            super._nameTxt.text = _data.template.TemplateName;
         }
         else
         {
            this.mouseEnabled = false;
            super._headIcon.icon = null;
            super._nameTxt.text = "";
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onLoaded);
         var _loc2_:String = MountAvatarPathHelper.getUrl(_data.template.AvatarPath);
         LoaderManagerII.instance.load(_loc2_,2,8,__onLoaded);
         _starBox.progress = _data.star;
         _starBox.count = _data.template.maxStarGrade;
      }
      
      private function __onLoaded(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Rectangle = null;
         if(isDie || !_data)
         {
            return;
         }
         var _loc4_:MovieClip = param2 as MovieClip;
         if(_loc4_)
         {
            _loc4_.gotoAndStop(2);
            _loc5_ = new BitmapData(500,500,true,0);
            _loc6_ = new Matrix();
            _loc6_.ty = 50;
            _loc5_.draw(_loc4_,_loc6_);
            _loc3_ = _loc5_.getColorBoundsRect(4278190080,0,false);
            _canvas.bitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _canvas.bitmapData.copyPixels(_loc5_,_loc3_,new Point(),null,null,true);
            _canvas.width = _loc3_.width * 0.6;
            _canvas.height = _loc3_.height * 0.6;
            _loc5_.dispose();
            if(_data.template.TemplateId == 1111)
            {
               _canvas.y = int((130 - _canvas.height) / 2) - 10;
            }
         }
         _loc4_ = null;
         _canvas.x = _canvas.y = 3;
         _canvas.width = _canvas.height = 50;
      }
      
      override public function mouseOver() : void
      {
         if(!enable)
         {
            return;
         }
         if(_overbg)
         {
            _overbg.visible = true;
         }
      }
      
      override public function mouseOut() : void
      {
         if(!enable)
         {
            return;
         }
         if(_overbg)
         {
            _overbg.visible = false;
         }
      }
      
      public function mouseClick() : void
      {
         FarmManager.instance.showMount(_data.templateId);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
         ObjectUtils.disposeObject(_canvas);
         _canvas = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

