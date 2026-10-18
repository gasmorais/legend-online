package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.DayGuideEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   import yishi.manager.TempleteManager;
   
   public class LimitedSellView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _topBg:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _back2:ScaleBitmapImage;
      
      private var _fetchItemDic:Dictionary;
      
      private var _activeProgress:ActiveProgressView;
      
      private var _tipArr:Array;
      
      private var _projectView:DailyProjectView;
      
      public function LimitedSellView()
      {
         super();
         initTips();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initTips() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.tip01");
         var _loc2_:String = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.tip02");
         var _loc3_:String = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.tip03");
         var _loc4_:String = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.tip04");
         _tipArr = [_loc1_,_loc2_,_loc3_,_loc4_];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveBoxBg");
         _topBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.ActiveBg");
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.LimitedSellView.Back");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("dayGuide.Bg1");
         _activeProgress = ComponentFactory.Instance.creatCustomObject("dayGuide.ActiveView.ActiveProgress");
         _projectView = ComponentFactory.Instance.creatCustomObject("dayGuide.projectView");
         addChild(_back);
         addChild(_bg);
         addChild(_topBg);
         addChild(_activeProgress);
         addChild(_projectView);
      }
      
      private function initFetchItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveBoxItem = null;
         _fetchItemDic = new Dictionary(true);
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new ActiveBoxItem();
            _loc1_.index = _loc2_;
            _loc1_.state = 1;
            _fetchItemDic[_loc2_] = _loc1_;
            _loc1_.tipData = getTipsStr(_loc2_);
            _loc2_++;
         }
      }
      
      private function getTipsStr(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc2_:Array = TempleteManager.instance.leedDropTemplateCate.getTemplatesByIndexAndIsWeek(param1,false);
         var _loc3_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc4_ == _loc2_.length - 1)
               {
                  if(_loc2_[_loc4_].itemId < 0)
                  {
                     _loc3_ += getGoodsName(_loc2_[_loc4_].itemId) + _loc2_[_loc4_].count + "";
                  }
                  else if(_loc2_[_loc4_].itemId > 0)
                  {
                     _loc3_ += getGoodsName(_loc2_[_loc4_].itemId) + _loc2_[_loc4_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03");
                  }
               }
               else if(_loc2_[_loc4_].itemId < 0)
               {
                  _loc3_ += getGoodsName(_loc2_[_loc4_].itemId) + _loc2_[_loc4_].count + ",\n";
               }
               else if(_loc2_[_loc4_].itemId > 0)
               {
                  _loc3_ += getGoodsName(_loc2_[_loc4_].itemId) + _loc2_[_loc4_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03") + ",\n";
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
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
         _activeProgress.data = cate.active;
         _projectView.data = cate.getShowAllList();
      }
      
      private function setAutoFormat(param1:FilterFrameText, param2:TextFormat) : void
      {
         var _loc3_:int = 0;
         param1.setTextFormat(param2);
         if(param1.textWidth > param1.width)
         {
            _loc3_ = int(param2.size);
            _loc3_ -= 1;
            param2.size = _loc3_;
            param1.setTextFormat(param2);
            setAutoFormat(param1,param2);
         }
      }
      
      private function getDescribe() : String
      {
         var _loc1_:String = null;
         if(cate.active >= 95)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.str01");
         }
         else if(cate.active >= 80)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.str02");
         }
         else if(cate.active >= 40)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.str03");
         }
         else if(cate.active >= 20)
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.str04");
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("dayGuide.view.ActiveView.str05");
         }
         return _loc1_;
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _fetchItemDic = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_activeProgress);
         _activeProgress = null;
         ObjectUtils.disposeObject(_projectView);
         _projectView = null;
         _tipArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

