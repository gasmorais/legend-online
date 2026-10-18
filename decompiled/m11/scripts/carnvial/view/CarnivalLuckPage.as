package carnvial.view
{
   import carnvial.item.CarnivalTurnItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.view.base.TextAddBitmap;
   
   public class CarnivalLuckPage extends BaseCarnivalPage
   {
      
      private var _item:CarnivalTurnItem;
      
      private var _roleImg:Bitmap;
      
      private var _allCountBg:Image;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _allCount:TextAddBitmap;
      
      public function CarnivalLuckPage()
      {
         super();
         initEvent();
         refreshView();
      }
      
      override protected function initView() : void
      {
         _roleImg = new Bitmap();
         _item = ComponentFactory.Instance.creatCustomObject("ui.carnival.CarnivalTurnItem");
         _allCountBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxtBg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxt");
         _allCount = ComponentFactory.Instance.creatCustomObject("ui.carnival.recharge.allCountBit");
         _allCount.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         addChild(_roleImg);
         addChild(_item);
         addChild(_allCountBg);
         addChild(_allCountTxt);
         addChild(_allCount);
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.luck.allGet");
         var _loc1_:int = int(model.configActId);
         toLoadImg(_roleImg,"tab3_role",_loc1_);
      }
      
      private function refreshView(param1:Boolean = false, param2:int = -1) : void
      {
         var _loc3_:int = getAllGetNum("" + model.luckNum);
         _allCount.setText("" + _loc3_);
         _item.refreshView(param1,param2);
      }
      
      private function getAllGetNum(param1:String) : int
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ += int(param1.substr(_loc3_ - _loc4_ - 1,_loc4_ + 1));
            _loc4_++;
         }
         return _loc2_;
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         refreshView(true,_loc2_);
      }
      
      override protected function clearView() : void
      {
         ObjectUtils.disposeObject(_roleImg);
         _roleImg = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_allCountBg);
         _allCountBg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_allCount);
         _allCount = null;
      }
   }
}

