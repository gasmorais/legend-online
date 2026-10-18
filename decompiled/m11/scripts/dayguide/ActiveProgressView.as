package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.DayGuideEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import managers.DayGuideManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   
   public class ActiveProgressView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _pressImg:Bitmap;
      
      private var _shapeMask:Shape;
      
      private var _actValue:FilterFrameText;
      
      private var activeConfigArr:Array;
      
      private var maxActive:int;
      
      private var _fetchItemDic:Dictionary;
      
      public function ActiveProgressView()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         cate.addEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.addEventListener("LEED_PROGRESS_CHANGE",__onUpdataHandler);
      }
      
      private function removeEvent() : void
      {
         cate.removeEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.removeEventListener("LEED_PROGRESS_CHANGE",__onUpdataHandler);
      }
      
      private function __onUpdataHandler(param1:DayGuideEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:ActiveBoxItem = null;
         for(var _loc2_:String in _fetchItemDic)
         {
            _loc1_ = _fetchItemDic[_loc2_] as ActiveBoxItem;
            if(cate.hasPick(int(_loc2_)))
            {
               _loc1_.state = 3;
            }
            else if(cate.canPick(int(_loc2_)))
            {
               _loc1_.state = 2;
            }
            else
            {
               _loc1_.state = 1;
            }
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveProgressBack");
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveProgressImg");
         _shapeMask = new Shape();
         _shapeMask.graphics.beginFill(0);
         _shapeMask.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _shapeMask.graphics.endFill();
         _shapeMask.x = _pressImg.x;
         _shapeMask.y = _pressImg.y;
         _pressImg.mask = _shapeMask;
         _actValue = ComponentFactory.Instance.creatComponentByStylename("dayGuide.actValueTxt");
         addChild(_back);
         addChild(_pressImg);
         addChild(_shapeMask);
         addChild(_actValue);
         initFetchItem();
      }
      
      private function initFetchItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveBoxItem = null;
         _fetchItemDic = new Dictionary(true);
         _loc2_ = 1;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("dayguide.ActiveBoxItem" + _loc2_);
            _loc1_.index = _loc2_;
            _loc1_.state = 1;
            _fetchItemDic[_loc2_] = _loc1_;
            _loc1_.tipData = cate.getLeedRewardTipsStr(_loc2_,false);
            addChild(_loc1_);
            _loc2_++;
         }
         maxActive = int(cate.dayActiveConfigValue[4]);
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      public function set data(param1:int) : void
      {
         _shapeMask.scaleX = param1 / maxActive;
         _actValue.text = param1.toString() + " / " + maxActive;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_actValue);
         _actValue = null;
         ObjectUtils.disposeObject(_shapeMask);
         _shapeMask = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

