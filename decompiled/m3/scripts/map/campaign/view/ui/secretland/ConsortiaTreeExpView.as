package map.campaign.view.ui.secretland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaSecretInfo;
   import yishi.manager.ConsortiaManager;
   
   public class ConsortiaTreeExpView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _powTxt:FilterFrameText;
      
      private var _powProgressImg:Bitmap;
      
      private var _powProgressMask:Shape;
      
      private var _data:ConsortiaSecretInfo;
      
      public function ConsortiaTreeExpView()
      {
         super();
         _data = ConsortiaManager.instance.model.secretInfo;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.campaign.TreeExpBg");
         _powTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaTreePowerTxt");
         _powProgressImg = ComponentFactory.Instance.creatBitmap("asset.campaign.TreePowProgressImg");
         _powProgressMask = new Shape();
         _powProgressMask.graphics.beginFill(16777215,0);
         _powProgressMask.graphics.drawRect(0,0,_powProgressImg.width,_powProgressImg.height);
         _powProgressMask.graphics.endFill();
         _powProgressMask.x = _powProgressImg.x;
         _powProgressMask.y = _powProgressImg.y;
         _powProgressImg.mask = _powProgressMask;
         addChild(_bg);
         addChild(_powProgressImg);
         addChild(_powProgressMask);
         addChild(_powTxt);
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("SECRET_UPDATE",__secretUpdateHandler);
         }
         model.addEventListener("UPDA_CONSORTIA_INFO",__secretUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("SECRET_UPDATE",__secretUpdateHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__secretUpdateHandler);
      }
      
      private function __secretUpdateHandler(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            clear();
            return;
         }
         _powTxt.text = _data.givePowerCount + " / " + (model.consortiaInfo.levels * 20 + 10);
         _powProgressMask.width = _powProgressImg.width * _data.givePowerCount / (model.consortiaInfo.levels * 20 + 10);
      }
      
      private function clear() : void
      {
         _powTxt.text = "0 / 0";
         _powProgressMask.width = 1;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_powTxt)
         {
            _powTxt.dispose();
         }
         _powTxt = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            _bg.bitmapData.dispose();
         }
         if(_powProgressImg)
         {
            if(_powProgressImg.parent)
            {
               _powProgressImg.parent.removeChild(_powProgressImg);
            }
            if(_powProgressImg.bitmapData)
            {
               _powProgressImg.bitmapData.dispose();
            }
            _powProgressImg.bitmapData = null;
            _powProgressImg.mask = null;
         }
         if(_powProgressMask)
         {
            _powProgressMask.graphics.clear();
            if(_powProgressImg.parent)
            {
               _powProgressImg.parent.removeChild(_powProgressImg);
            }
         }
         _bg = null;
         _powProgressImg = null;
         _powProgressMask = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

