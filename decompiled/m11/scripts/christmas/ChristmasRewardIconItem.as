package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.view.community.BaseItemView;
   
   public class ChristmasRewardIconItem extends Sprite implements Disposeable
   {
      
      private var _goods:BaseItemView;
      
      private var _icon:Bitmap;
      
      private var _data:ChristmasLotteryTempInfo;
      
      private var _eff:MovieImage;
      
      private var _isPlay:Boolean = false;
      
      public function ChristmasRewardIconItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _goods = ComponentFactory.Instance.creatCustomObject("christmasRewardIconItem.goodsItemView");
         _icon = ComponentFactory.Instance.creatBitmap("asset.ChristmasRewardIconItem.icon");
         _eff = ComponentFactory.Instance.creatComponentByStylename("core.EquipActiveBack");
         addChild(_goods);
         addChild(_icon);
         addChild(_eff);
         _eff.x = -4;
         _eff.y = -3;
         _eff.width = 56;
         _eff.height = 56;
         _eff.movie.gotoAndStop(1);
         _eff.visible = false;
         _eff.mouseChildren = _eff.mouseEnabled = false;
         _goods.data = null;
         _icon.visible = false;
      }
      
      private function addEvent() : void
      {
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         if(model.jackpotRewardInfo && model.jackpotRewardInfo.indexOf(_data.Id.toString()) != -1)
         {
            _icon.visible = true;
            _eff.movie.gotoAndStop(1);
            _eff.visible = false;
         }
         else
         {
            _icon.visible = false;
            if(_isPlay)
            {
               _eff.movie.gotoAndPlay(1);
               _eff.visible = true;
            }
            else
            {
               _eff.movie.gotoAndStop(1);
               _eff.visible = false;
            }
         }
      }
      
      public function set isPlay(param1:Boolean) : void
      {
         _isPlay = param1;
         refreshView();
      }
      
      public function set data(param1:ChristmasLotteryTempInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _data.ItemId;
            _loc2_.count = _data.Num;
            _goods.data = _loc2_;
         }
         refreshView();
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_eff);
         _eff = null;
      }
   }
}

