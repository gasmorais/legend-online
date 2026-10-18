package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.DayGuideSocketOutManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.SimpleAlertHelper;
   
   public class ActiveBoxItem extends Component
   {
      
      public static const DEFAULT:int = 1;
      
      public static const OPEN:int = 2;
      
      public static const CLOSE:int = 3;
      
      private var _back:ScaleFrameImage;
      
      private var _activeText:FilterFrameText;
      
      private var _index:int;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var activeConfigArr:Array;
      
      private var type:int;
      
      private var _isWeek:Boolean;
      
      private var _sendIndex:int;
      
      public function ActiveBoxItem(param1:int = 1)
      {
         super();
         type = param1;
         initView();
      }
      
      private function initView() : void
      {
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 40;
         isFollowMouse = false;
         _activeText = ComponentFactory.Instance.creatComponentByStylename("ActiveBoxItem.activeText");
         addChild(_activeText);
      }
      
      private function initEvent() : void
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
         SoundManager.instance.play("022");
         _isWeek = type == 1 ? false : true;
         _sendIndex = type == 1 ? _index : _index - 2;
         if(_isWeek)
         {
            _loc4_ = DateFormatter.parse(cate.buffStopDate,"YYYY-MM-DD hh:mm:ss");
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.time > playerModel.nowDate)
            {
               DayGuideSocketOutManager.sendGetGoods(_sendIndex,_isWeek);
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
            DayGuideSocketOutManager.sendGetGoods(_sendIndex,_isWeek);
         }
      }
      
      private function _buyDoubleActiveHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= ConfigInfoManager.instance.getLeedBuyBuffPoint())
            {
               DayGuideSocketOutManager.sendbuyDoubleBuff();
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
         else
         {
            DayGuideSocketOutManager.sendGetGoods(_sendIndex,_isWeek);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function set index(param1:int) : void
      {
         var _loc2_:int = 0;
         _index = param1;
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ActiveBoxImg");
         _disEffect = new NoviceBtnGlowEffect(_back,9);
         _back.setFrame(param1);
         addChildAt(_back,0);
         if(type == 1)
         {
            _loc2_ = int(cate.dayActiveConfigValue[param1 - 1]);
            _activeText.text = LanguageMgr.GetTranslation("dayGuide.ActiveBoxText.text",_loc2_);
            _back.scaleX = _back.scaleY = 1;
         }
         else
         {
            _activeText.text = "";
            _back.scaleX = _back.scaleY = 0.8;
         }
      }
      
      public function set state(param1:int) : void
      {
         buttonMode = false;
         _disEffect.stop();
         this.filters = [];
         if(param1 == 2)
         {
            buttonMode = true;
            _disEffect.play();
            initEvent();
         }
         else if(param1 == 3)
         {
            this.filters = [UIFilter.getBlackFilter()];
         }
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_activeText);
         _activeText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

