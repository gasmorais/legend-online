package ancientartifact.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   
   public class AncientStarsItem extends Component
   {
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
      private var _hBox:HBox;
      
      public function AncientStarsItem(param1:ArtifactTemplateInfo, param2:AncientArtifactInfo)
      {
         super();
         _template = param1;
         _data = param2;
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:Bitmap = null;
         var _loc6_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc8_:int = 0;
         var _loc9_:Bitmap = null;
         _hBox = ComponentFactory.Instance.creatComponentByStylename("AncientArtifactItem.HBox");
         addChild(_hBox);
         if(_data)
         {
            if(_data.level >= 1 && _data.level <= 5)
            {
               _loc3_ = "asset.ancientartifact.starLightImg";
               _loc4_ = "asset.ancientartifact.starDarkImg";
            }
            else if(_data.level >= 6 && _data.level <= 10)
            {
               _loc3_ = "asset.ancientartifact.moonLightImg";
               _loc4_ = "asset.ancientartifact.moonDarkImg";
            }
            else if(_data.level >= 11 && _data.level <= 15)
            {
               _loc3_ = "asset.ancientartifact.sunLightImg";
               _loc4_ = "asset.ancientartifact.sunDarkImg";
            }
            _loc2_ = _data.level % 5 == 0 ? 5 : _data.level % 5;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc7_ = ComponentFactory.Instance.creatBitmap(_loc3_);
               _hBox.addChild(_loc7_);
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < 5 - _loc2_)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap(_loc4_);
               _hBox.addChild(_loc1_);
               _loc6_++;
            }
         }
         else
         {
            _loc4_ = "asset.ancientartifact.starDarkImg";
            _loc8_ = 0;
            while(_loc8_ < 5)
            {
               _loc9_ = ComponentFactory.Instance.creatBitmap(_loc4_);
               _hBox.addChild(_loc9_);
               _loc8_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         _template = null;
         _data = null;
         super.dispose();
      }
   }
}

