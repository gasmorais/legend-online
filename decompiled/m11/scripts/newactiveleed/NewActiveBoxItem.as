package newactiveleed
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NewActiveLeedManager;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   
   public class NewActiveBoxItem extends Component
   {
      
      public static const DEFAULT:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const CLOSE:int = 3;
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _index:int;
      
      private var _isWeek:Boolean;
      
      private var _txtBg:Bitmap;
      
      public function NewActiveBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("NewActiveBoxItem.bg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedFrame.iconImg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("NewActiveBoxItem.txt");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedFrame.weekBoxBg");
         addChild(_bg);
         addChild(_txtBg);
         _txtBg.visible = false;
         addChild(_icon);
         addChild(_txt);
         _disEffect = new NoviceBtnGlowEffect(_bg,9);
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 40;
         isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(_isWeek)
         {
            _loc4_ = DateFormatter.parse(model.buffTime,"YYYY-MM-DD hh:mm:ss");
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.time > playerModel.nowDate)
            {
               NewActiveLeedManager.instance.sendGetReward(model.masterType,_index,_isWeek);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("dayguide.newleed.doubleActiveText",ConfigInfoManager.instance.getLeedBuyBuffPoint());
               SimpleAlertHelper.instance.data = [_buyDoubleActiveHandler];
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2);
            }
         }
         else
         {
            NewActiveLeedManager.instance.sendGetReward(model.masterType,_index,_isWeek);
         }
      }
      
      private function _buyDoubleActiveHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(playerModel.playerInfo.point >= ConfigInfoManager.instance.getLeedBuyBuffPoint())
            {
               NewActiveLeedManager.instance.sendBuyBuff();
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
         else
         {
            NewActiveLeedManager.instance.sendGetReward(model.masterType,_index,_isWeek);
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:Array = null;
         var _loc6_:Object = null;
         var _loc1_:String = null;
         var _loc3_:int = 0;
         var _loc8_:SimpleDictionary = _isWeek ? weekDropDic : dailyDropDic;
         if(_loc8_.keys.length > 0)
         {
            _loc4_ = _loc8_.slice();
            _loc4_.sortOn("key",16);
            _loc6_ = _loc4_[_index];
            _txt.text = _loc6_.key.toString();
            _loc3_ = int(_loc6_.key);
            _loc1_ = getRewardTipsStr(_loc6_.value);
            this.tipData = _loc1_;
         }
         var _loc2_:Array = _isWeek ? model.weekProcessArr : model.dailyProcessArr;
         var _loc5_:int = int(_isWeek ? model.weekNum : int(model.dailyNum));
         var _loc7_:int = int(_loc2_[_index]);
         if(_loc7_ == 0)
         {
            if(_loc3_ <= _loc5_)
            {
               state = 2;
            }
            else
            {
               state = 1;
            }
         }
         else if(_loc7_ == 1)
         {
            state = 3;
         }
      }
      
      public function getRewardTipsStr(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(_loc3_ == param1.length - 1)
               {
                  _loc2_ += getGoodsName(param1[_loc3_].itemId) + "*" + param1[_loc3_].count;
               }
               else
               {
                  _loc2_ += getGoodsName(param1[_loc3_].itemId) + "*" + param1[_loc3_].count + ",\n";
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      public function updateView(param1:int, param2:Boolean) : void
      {
         _index = param1;
         _isWeek = param2;
         if(!_isWeek)
         {
            _bg.setFrame(_index + 1);
            _bg.y = 0;
            _icon.x = 5;
            _txt.x = 18;
            _txtBg.visible = false;
         }
         else
         {
            _bg.setFrame(_index + 6);
            _bg.y = -10;
            _icon.x = -20;
            _txt.x = -7;
            _txtBg.visible = true;
         }
         refreshView();
      }
      
      public function set state(param1:int) : void
      {
         removeEvent();
         buttonMode = false;
         _disEffect.stop();
         this.filters = [];
         if(param1 == 2)
         {
            buttonMode = true;
            _disEffect.play();
            addEvent();
         }
         else if(param1 == 3)
         {
            this.filters = [UIFilter.getBlackFilter()];
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : NewActiveLeedModel
      {
         return NewActiveLeedManager.instance.model;
      }
      
      private function get dailyDropDic() : SimpleDictionary
      {
         return TempleteManager.instance.newActiveLeedDailyCate.getDropGoods(model.masterType);
      }
      
      private function get weekDropDic() : SimpleDictionary
      {
         return TempleteManager.instance.newActiveLeedWeekCate.getDropGoods(model.masterType);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_disEffect);
         _disEffect = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

