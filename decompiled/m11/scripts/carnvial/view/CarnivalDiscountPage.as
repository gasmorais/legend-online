package carnvial.view
{
   import carnvial.item.CarnivalGiftBox;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TextAddBitmap;
   
   public class CarnivalDiscountPage extends BaseCarnivalPage
   {
      
      private var _allCountBg:Image;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _allCount:TextAddBitmap;
      
      private var _restTxtBg:Bitmap;
      
      private var _resttxt:FilterFrameText;
      
      private var _upRightBit:Bitmap;
      
      private var _downLeftBit:Bitmap;
      
      private var _tempList:Array;
      
      private var _dic:Dictionary = new Dictionary();
      
      private const TYPE_GIFT:int = 2;
      
      private const POS_LIST:Array = [[33,19],[352,8],[202,263],[534,239]];
      
      public function CarnivalDiscountPage()
      {
         super();
         initData();
         initEvent();
         refreshView();
      }
      
      override protected function initView() : void
      {
         _upRightBit = new Bitmap();
         _downLeftBit = new Bitmap();
         _allCountBg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxtBg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechargeCountTxt");
         _allCount = ComponentFactory.Instance.creatCustomObject("ui.carnival.recharge.allCountBit");
         _allCount.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _restTxtBg = ComponentFactory.Instance.creatBitmap("asset.carniver.timeSetBg");
         _resttxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.retTimeTxt");
         addChild(_upRightBit);
         addChild(_downLeftBit);
         addChild(_allCountBg);
         addChild(_allCountTxt);
         addChild(_allCount);
         addChild(_restTxtBg);
         addChild(_resttxt);
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.today");
         _resttxt.htmlText = LanguageMgr.GetTranslation("carnival.today.reset");
         _upRightBit.x = 666;
         _upRightBit.y = 58;
         _downLeftBit.x = 30;
         _downLeftBit.y = 320;
         toLoadImg(_upRightBit,"tab4_up",_activeId);
         toLoadImg(_downLeftBit,"tab4_down",_activeId);
      }
      
      private function initData() : void
      {
         var _loc8_:Array = null;
         var _loc9_:Dictionary = null;
         var _loc4_:Array = null;
         var _loc5_:CarnivalPointExchangeTemplateInfo = null;
         var _loc2_:CarnivalGiftBox = null;
         var _loc6_:int = 0;
         var _loc7_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("carnival_buy_gift_limit");
         if(_loc7_ != null)
         {
            _loc9_ = new Dictionary();
            _loc8_ = _loc7_.ConfigValue.split("|");
            for each(var _loc1_:String in _loc8_)
            {
               _loc4_ = _loc1_.split(",");
               _loc9_[_loc4_[0]] = int(_loc4_[1]);
            }
         }
         _tempList = TempleteManager.instance.carnivalPointExchangeCate.getTempListByType(2);
         var _loc3_:int = int(_tempList ? _tempList.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _tempList[_loc6_];
            _loc2_ = new CarnivalGiftBox(_loc6_ + 1,_loc9_);
            _loc2_.tempInfo = _loc5_;
            addChild(_loc2_);
            _loc2_.x = POS_LIST[_loc6_][0];
            _loc2_.y = POS_LIST[_loc6_][1];
            _dic[_loc5_.Id] = _loc2_;
            _loc6_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc3_:CarnivalPointExchangeTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc1_:int = int(model.dayCharge);
         _allCount.setText("" + _loc1_);
         var _loc2_:int = int(_tempList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _tempList[_loc4_];
            _dic[_loc3_.Id].refreshView();
            _loc4_++;
         }
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      override protected function clearView() : void
      {
         for each(var _loc1_:DisplayObject in _dic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _dic = null;
         ObjectUtils.disposeObject(_allCountBg);
         _allCountBg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_allCount);
         _allCount = null;
         ObjectUtils.disposeObject(_restTxtBg);
         _restTxtBg = null;
         ObjectUtils.disposeObject(_resttxt);
         _resttxt = null;
         ObjectUtils.disposeObject(_upRightBit);
         _upRightBit = null;
         ObjectUtils.disposeObject(_downLeftBit);
         _downLeftBit = null;
         _tempList = null;
      }
   }
}

