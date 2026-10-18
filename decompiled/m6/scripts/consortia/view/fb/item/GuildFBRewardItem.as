package consortia.view.fb.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBRewardItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class GuildFBRewardItem extends Sprite implements Disposeable
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _rewardHbox:HBox;
      
      private var _data:GuildFBRewardItemInfo;
      
      public function GuildFBRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRewardItem.rankTxt");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("guildFBRewardItem.rewardHbox");
         addChild(_rankTxt);
         addChild(_rewardHbox);
      }
      
      private function unInitView() : void
      {
         if(_rankTxt)
         {
            ObjectUtils.disposeObject(_rankTxt);
         }
         _rankTxt = null;
         if(_rewardHbox)
         {
            ObjectUtils.disposeObject(_rewardHbox);
         }
         _rewardHbox = null;
      }
      
      public function set data(param1:GuildFBRewardItemInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            _rankTxt.text = "";
            _rewardHbox.removeAllChild();
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         if(_rewardHbox)
         {
            _rewardHbox.removeAllChild();
         }
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         if(_data.firstOrder == _data.lastOrder)
         {
            _rankTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.item.rankTxt" + _data.firstOrder);
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.item.rankTxt0",_data.firstOrder,_data.lastOrder);
         }
         _loc2_ = _data.itemIdStr.split(",");
         _loc1_ = _data.countStr.split(",");
         var _loc4_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_ - 1)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("guildFBRankItem.BaseItemView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc2_[_loc5_];
            _loc6_.count = _loc1_[_loc5_];
            _loc6_.showCount = true;
            _loc3_.data = _loc6_;
            _rewardHbox.addChild(_loc3_);
            _loc5_++;
         }
         _rewardHbox.x = _rankTxt.x + _rankTxt.textWidth + 5;
      }
      
      public function dispose() : void
      {
         unInitView();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

