package supersignincard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SuperSigninCardManager;
   import mvc.module.supersignincard.SuperSigninCardModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class SuperSigninCardItem extends Component
   {
      
      private var _dayBmp:Bitmap;
      
      private var _dayTxt:FilterFrameText;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _receiveBtn:IconButton;
      
      private var _receivedBtn:IconButton;
      
      private var _signinBtn:IconButton;
      
      private var _index:int;
      
      private const MAX_NUM:int = 8;
      
      public function SuperSigninCardItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _dayBmp = ComponentFactory.Instance.creatBitmap("asset.SuperSigninCardItem.day");
         _dayTxt = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardItem.dayTxt");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardItem.receiveBtn");
         _receivedBtn = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardItem.receivedBtn");
         _signinBtn = ComponentFactory.Instance.creatComponentByStylename("SuperSigninCardItem.signinBtn");
         addChild(_dayBmp);
         addChild(_dayTxt);
         addChild(_receivedBtn);
         _receivedBtn.enable = false;
         addChild(_signinBtn);
         addChild(_receiveBtn);
         _dayTxt.text = "" + _index;
         initItem();
         refreshItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         _itemList = new Vector.<BaseItemView>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc1_.x = _loc2_ % 2 * 55;
            _loc1_.y = 40 + int(_loc2_ / 2) * 65;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshItem() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc4_:int = 0;
         var _loc1_:String = model.tempDic[_index];
         var _loc2_:Array = GoodsHelp.getCommonRewardAry(_loc1_);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            if(_loc2_[_loc4_])
            {
               _loc3_ = _itemList[_loc4_];
               _loc5_ = _loc2_[_loc4_] as GoodsInfo;
               _loc3_.data = _loc5_;
               _loc3_.visible = true;
            }
            else
            {
               _loc3_ = _itemList[_loc4_];
               _loc3_.visible = false;
            }
            _loc4_++;
         }
      }
      
      public function refreshView() : void
      {
         _receiveBtn.visible = false;
         _signinBtn.visible = false;
         var _loc1_:int = int(model.stateDic[_index]);
         switch(_loc1_)
         {
            case 0:
               _receiveBtn.visible = true;
               _receiveBtn.enable = false;
               break;
            case 1:
               _receiveBtn.visible = true;
               _receiveBtn.enable = true;
               break;
            case 3:
               _signinBtn.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveBtnClickHandler);
         _signinBtn.addEventListener("click",__signinBtnClickHandler);
      }
      
      private function __receiveBtnClickHandler(param1:MouseEvent) : void
      {
         SuperSigninCardManager.instance.sendRequest(3,_index);
      }
      
      private function __signinBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [callBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("SuperSigninCardItem.signinBtnClick.text",model.reSigninPrice);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < model.reSigninPrice)
            {
               RechargeAlertMannager.show();
               return;
            }
            SuperSigninCardManager.instance.sendRequest(4,_index);
         }
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receiveBtnClickHandler);
         _signinBtn.removeEventListener("click",__signinBtnClickHandler);
      }
      
      private function get model() : SuperSigninCardModel
      {
         return SuperSigninCardManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

