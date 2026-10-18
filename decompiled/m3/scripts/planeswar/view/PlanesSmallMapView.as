package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import yishi.datas.templates.PlanesTemplateInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   
   public class PlanesSmallMapView extends Component
   {
      
      private var viewBg:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var fog:Bitmap;
      
      private var heroPointImage:Bitmap;
      
      private var lastPointImage:Bitmap;
      
      private var nextPointImage:Bitmap;
      
      private var planesName:FilterFrameText;
      
      private var easeObj:Object = {};
      
      private var continer:Component;
      
      private var eraseBitmap:Bitmap;
      
      private var eraseBitmapData:BitmapData;
      
      private var gridArrInfos:Array;
      
      public function PlanesSmallMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         viewBg = ComponentFactory.Instance.creatComponentByStylename("PlanesSmallMapView.ViewBack");
         planesName = ComponentFactory.Instance.creatComponentByStylename("PlanesSmallMapView.planesName");
         back = ComponentFactory.Instance.creatBitmap("asset.PlanesSmallMapView.back" + model.currentSize);
         fog = ComponentFactory.Instance.creatBitmap("asset.PlanesSmallMapView.fog" + model.currentSize);
         heroPointImage = ComponentFactory.Instance.creatBitmap("asset.PlanesSmallMapView.heroPointImage");
         lastPointImage = ComponentFactory.Instance.creatBitmap("asset.PlanesSmallMapView.lastPointImage");
         nextPointImage = ComponentFactory.Instance.creatBitmap("asset.PlanesSmallMapView.nextPointImage");
         continer = new Component();
         eraseBitmap = new Bitmap(new BitmapData(back.width,back.height,true,0));
         eraseBitmapData = ComponentFactory.Instance.creatBitmapData("asset.PlanesSmallMapView.easeImage");
         addChild(viewBg);
         addChild(planesName);
         addChild(back);
         addChild(continer);
         continer.blendMode = "layer";
         continer.addChild(fog);
         continer.addChild(eraseBitmap);
         eraseBitmap.blendMode = "erase";
         addChild(heroPointImage);
         back.x = (viewBg.width - back.width) / 2;
         back.y = (viewBg.height - 34 - back.height) / 2 + 34;
         continer.x = back.x + 1;
         continer.y = back.y + 1;
         __updateHeroPosHandler(null);
         refreshView();
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_GRIDINFO_UPDATE",__updateGridInfoHandler);
         PlanesWarManager.instance.addEventListener("SMALL_MAP_HEROUPDATE",__updateHeroPosHandler);
      }
      
      private function __updateGridInfoHandler(param1:PlanesWarEvent) : void
      {
         refreshView();
      }
      
      private function __updateHeroPosHandler(param1:PlanesWarEvent) : void
      {
         if(heroPointImage && heroPointImage.parent)
         {
            heroPointImage.x = back.x + model.planesWarInfo.posX * 10 + 5 - heroPointImage.width / 2;
            heroPointImage.y = back.y + model.planesWarInfo.posY * 10 + 5 - heroPointImage.height / 2;
         }
      }
      
      public function refreshView() : void
      {
         var _loc7_:int = 0;
         var _loc3_:PlanesGridInfo = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc9_:Point = null;
         var _loc1_:Rectangle = null;
         if(lastPointImage && lastPointImage.parent)
         {
            lastPointImage.parent.removeChild(lastPointImage);
         }
         if(nextPointImage && nextPointImage.parent)
         {
            nextPointImage.parent.removeChild(nextPointImage);
         }
         gridArrInfos = model.planesWarInfo.gridArr;
         var _loc6_:PlanesTemplateInfo = TempleteManager.instance.planesTemplateCate.getTemplateByID(model.planesWarInfo.planesTempId);
         if(_loc6_)
         {
            planesName.text = _loc6_.PlanesName;
         }
         if(model.checkGridInfoByEventId(1) && model.checkGridInfoByEventId(1).opened)
         {
            addChild(lastPointImage);
         }
         if(model.checkGridInfoByEventId(2) && model.checkGridInfoByEventId(2).opened)
         {
            addChild(nextPointImage);
         }
         var _loc2_:int = int(gridArrInfos.length);
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = gridArrInfos[_loc7_];
            if(_loc3_)
            {
               if(_loc3_.opened)
               {
                  _loc8_ = _loc3_.x * 100 + _loc3_.y;
                  _loc4_ = int(easeObj[_loc8_]);
                  if(_loc4_ <= 0)
                  {
                     _loc5_ = eraseBitmapData.clone();
                     _loc9_ = _loc9_ = new Point(_loc3_.x * 10,_loc3_.y * 10);
                     _loc1_ = _loc5_.getColorBoundsRect(4278190080,0,true);
                     eraseBitmap.bitmapData.copyPixels(_loc5_,_loc1_,_loc9_,null,null,true);
                     easeObj[_loc8_] = 1;
                  }
               }
            }
            _loc7_++;
         }
         setViewPos();
      }
      
      private function setViewPos() : void
      {
         var _loc1_:PlanesGridInfo = null;
         var _loc2_:PlanesGridInfo = null;
         if(heroPointImage && heroPointImage.parent)
         {
            heroPointImage.x = back.x + model.planesWarInfo.posX * 10 + 5 - heroPointImage.width / 2;
            heroPointImage.y = back.y + model.planesWarInfo.posY * 10 + 5 - heroPointImage.height / 2;
         }
         if(lastPointImage && lastPointImage.parent)
         {
            _loc1_ = model.checkGridInfoByEventId(1);
            if(_loc1_)
            {
               lastPointImage.x = back.x + _loc1_.x * 10 + 5 - lastPointImage.width / 2;
               lastPointImage.y = back.y + _loc1_.y * 10 + 5 - lastPointImage.height / 2;
            }
         }
         if(nextPointImage && nextPointImage.parent)
         {
            _loc2_ = model.checkGridInfoByEventId(2);
            if(_loc2_)
            {
               nextPointImage.x = back.x + _loc2_.x * 10 + 5 - nextPointImage.width / 2;
               nextPointImage.y = back.y + _loc2_.y * 10 + 5 - nextPointImage.height / 2;
            }
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_GRIDINFO_UPDATE",__updateGridInfoHandler);
         PlanesWarManager.instance.removeEventListener("SMALL_MAP_HEROUPDATE",__updateHeroPosHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         gridArrInfos = null;
         easeObj = null;
         if(viewBg)
         {
            ObjectUtils.disposeObject(viewBg);
         }
         viewBg = null;
         if(planesName)
         {
            ObjectUtils.disposeObject(planesName);
         }
         planesName = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(fog)
         {
            ObjectUtils.disposeObject(fog);
         }
         fog = null;
         if(heroPointImage)
         {
            ObjectUtils.disposeObject(heroPointImage);
         }
         heroPointImage = null;
         if(lastPointImage)
         {
            ObjectUtils.disposeObject(lastPointImage);
         }
         lastPointImage = null;
         if(nextPointImage)
         {
            ObjectUtils.disposeObject(nextPointImage);
         }
         nextPointImage = null;
         if(eraseBitmap)
         {
            ObjectUtils.disposeObject(eraseBitmap);
         }
         eraseBitmap = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

