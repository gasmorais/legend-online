package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildInsetItemView extends Component
   {
      
      private var _state:int;
      
      private var _itemView:BaseItemView;
      
      private var _bgView:Bitmap;
      
      private var _gemView:Bitmap;
      
      private var _lockView:ScaleFrameImage;
      
      private var _openBtn:BaseButton;
      
      private var _openTipTxt:FilterFrameText;
      
      private var _pos:int;
      
      private var _data:GoodsInfo;
      
      private var _time:Number;
      
      public function ChildInsetItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgView = ComponentFactory.Instance.creatBitmap("asset.ChildInsetItemView.bg");
         _gemView = ComponentFactory.Instance.creatBitmap("asset.child.equip.gem");
         _itemView = ComponentFactory.Instance.creatCustomObject("ChildInsetItemView.itemView");
         _lockView = ComponentFactory.Instance.creatCustomObject("ChildInsetItemView.lockView");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("ChildInsetItemView.openBtn");
         _openTipTxt = ComponentFactory.Instance.creatComponentByStylename("godHeadItemView.openTipTxt");
         addChild(_bgView);
         addChild(_gemView);
         addChild(_lockView);
         addChild(_itemView);
         addChild(_openBtn);
         addChild(_openTipTxt);
         _openTipTxt.text = LanguageMgr.GetTranslation("godHeadItemView.openTipTxt");
         state = 3;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_bgView);
         _bgView = null;
         ObjectUtils.disposeObject(_gemView);
         _gemView = null;
         ObjectUtils.disposeObject(_lockView);
         _lockView = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_openTipTxt);
         _openTipTxt = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         if(_openBtn)
         {
            _openBtn.addEventListener("click",__openHandler);
         }
         if(_itemView)
         {
            _itemView.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openHandler);
         }
         if(_itemView)
         {
            _itemView.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:Number = getTimer();
         if(_loc4_ - _time < 300)
         {
            if(_data)
            {
               if(_data.fightUserId > 0 && _data.fightUserId != playerInfo.userId)
               {
                  if(ChildManager.instance.model.hideGoods.userId > 0)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
                     return;
                  }
               }
               SimpleAlertHelper.instance.data = [__removeJewelCallBack];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.content03",data.templateInfo.Property3);
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_);
               return;
            }
         }
         _time = _loc4_;
      }
      
      private function __removeJewelCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(gold.count < _data.templateInfo.Property3)
            {
               _loc3_ = LanguageMgr.GetTranslation("public.gold");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            ChildSender.openHole(pos,false,param2);
         }
      }
      
      private function __openHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:ConfigInfosTempInfo = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         if(model.hideGoods == null || ChildManager.instance.curSelectChild == null)
         {
            return;
         }
         if(_state == 1)
         {
            _loc6_ = 10;
            _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("equi_item_need");
            if(_loc4_ && parseInt(_loc4_.ConfigValue))
            {
               _loc6_ = parseInt(_loc4_.ConfigValue);
            }
            SimpleAlertHelper.instance.data = [openHole];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("child.equip.ChildInsetItemView.openHoleTip",_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc7_,_loc2_,_loc3_,true,true,true,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function openHole(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ChildSender.openHole(pos,true,param2);
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         _lockView.visible = false;
         _openBtn.visible = false;
         _openTipTxt.visible = false;
         switch(_state)
         {
            case 0:
               _lockView.visible = true;
               _openTipTxt.visible = true;
               _lockView.setFrame(1);
               break;
            case 1:
               _lockView.visible = true;
               _openBtn.visible = true;
               _lockView.setFrame(2);
               break;
            case 2:
               break;
            case 3:
               _lockView.visible = true;
               _lockView.setFrame(1);
               break;
            default:
               _lockView.visible = true;
               _openTipTxt.visible = true;
               _lockView.setFrame(1);
         }
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _itemView.data = param1;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

