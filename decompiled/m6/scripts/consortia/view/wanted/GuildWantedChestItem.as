package consortia.view.wanted
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.guildwanted.GuildWantedModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.filter.UIFilter;
   import yishi.manager.GuildWantedManager;
   import yishi.manager.TempleteManager;
   
   public class GuildWantedChestItem extends Component
   {
      
      private var _chest:Image;
      
      private var _btn:IconButton;
      
      private var _txt:FilterFrameText;
      
      private var _index:int;
      
      private var _type:int;
      
      private var _score:int;
      
      public function GuildWantedChestItem(param1:int, param2:int)
      {
         super();
         _index = param1;
         _type = param2;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _chest = ComponentFactory.Instance.creatComponentByStylename("GuildWantedChestItem.chestIcon");
         _btn = ComponentFactory.Instance.creatComponentByStylename("GuildWantedChestItem.btn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("GuildWantedChestItem.txt");
         addChild(_chest);
         addChild(_btn);
         _btn.visible = false;
         addChild(_txt);
         initScore();
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 40;
         isFollowMouse = false;
         tipData = rewardTipsStr;
      }
      
      private function initScore() : void
      {
         var _loc1_:Array = ConfigInfoManager.instance.getGuildWantedSelfBoxScore();
         var _loc2_:Array = ConfigInfoManager.instance.getGuildWantedGuildBoxScore();
         _score = isSelf ? _loc1_[_index] : _loc2_[_index];
         _txt.text = _score + "";
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         GuildWantedManager.instance.sendRequest(4,_index,_type);
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(isSelf ? model.selfBoxState[_index] : model.guildBoxState[_index]);
         if(_loc2_ == 1)
         {
            _chest.filters = [UIFilter.getGrayFilter()];
            _btn.visible = false;
         }
         else
         {
            _loc1_ = int(isSelf ? model.personalScore : int(model.consortiaScore));
            if(_loc1_ >= _score)
            {
               _btn.visible = true;
            }
            else
            {
               _chest.filters = [];
               _btn.visible = false;
            }
         }
      }
      
      public function get rewardTipsStr() : String
      {
         var _loc3_:int = 0;
         var _loc1_:Array = TempleteManager.instance.guildWantedDropTempCate.getDropsByTypeIndex(_type,_index.toString());
         var _loc2_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         if(_loc1_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(_loc3_ == _loc1_.length - 1)
               {
                  if(_loc1_[_loc3_].itemId < 0)
                  {
                     _loc2_ += getGoodsName(_loc1_[_loc3_].itemId) + _loc1_[_loc3_].count + "";
                  }
                  else if(_loc1_[_loc3_].itemId > 0)
                  {
                     _loc2_ += getGoodsName(_loc1_[_loc3_].itemId) + _loc1_[_loc3_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03");
                  }
               }
               else if(_loc1_[_loc3_].itemId < 0)
               {
                  _loc2_ += getGoodsName(_loc1_[_loc3_].itemId) + _loc1_[_loc3_].count + ",\n";
               }
               else if(_loc1_[_loc3_].itemId > 0)
               {
                  _loc2_ += getGoodsName(_loc1_[_loc3_].itemId) + _loc1_[_loc3_].count + LanguageMgr.GetTranslation("shop.view.frame.BuyFrame.vipBuyInfo03") + ",\n";
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
      
      public function get model() : GuildWantedModel
      {
         return GuildWantedManager.instance.model;
      }
      
      private function get isSelf() : Boolean
      {
         return _type == 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_chest);
         _chest = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

