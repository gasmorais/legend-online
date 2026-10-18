package consortia.view.fb.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBNode;
   import mvc.module.guildfb.GuildFBRankItemInfo;
   import mvc.module.guildfb.GuildFBRewardItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseItemView;
   
   public class GuildFBRankItem extends Sprite implements Disposeable
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _guildNameTxt:FilterFrameText;
      
      private var _currentLevelTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _seasonRewardHox:HBox;
      
      private var _data:GuildFBRankItemInfo;
      
      public function GuildFBRankItem()
      {
         super();
         initView();
      }
      
      public function set data(param1:GuildFBRankItemInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            _rankTxt.text = "";
            _guildNameTxt.text = "";
            _currentLevelTxt.text = "";
            _progressTxt.text = "";
            _seasonRewardHox.removeAllChild();
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:Array = null;
         var _loc4_:GuildFBRewardItemInfo = null;
         var _loc3_:int = 0;
         _rankTxt.text = _data.order.toString();
         _guildNameTxt.text = _data.consortiaName + "[" + _data.serverName + "]";
         var _loc1_:GuildFBNode = new GuildFBNode();
         _loc1_.nodeID = _data.currentLevel;
         if(_loc1_.currTempInfo)
         {
            _currentLevelTxt.text = _loc1_.currTempInfo.Name;
         }
         if(model.raceNode.state == 1)
         {
            _progressTxt.visible = true;
            _seasonRewardHox.visible = false;
            _progressTxt.text = _data.progress + "%";
         }
         else if(model.raceNode.state == 2)
         {
            _progressTxt.visible = false;
            _seasonRewardHox.visible = true;
            _loc2_ = model.getRewardArray();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_] as GuildFBRewardItemInfo;
               if(_loc4_ && _data.order >= _loc4_.firstOrder && _data.order <= _loc4_.lastOrder)
               {
                  refreshHbox(_loc4_);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function refreshHbox(param1:GuildFBRewardItemInfo) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         _seasonRewardHox.removeAllChild();
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         _loc3_ = param1.itemIdStr.split(",");
         _loc2_ = param1.countStr.split(",");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length - 1)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("guildFBRankItem.BaseItemView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc3_[_loc5_];
            _loc6_.count = _loc2_[_loc5_];
            _loc6_.showCount = true;
            _loc4_.data = _loc6_;
            _seasonRewardHox.addChild(_loc4_);
            _loc5_++;
         }
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankItem.rankTxt");
         _guildNameTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankItem.guildNameTxt");
         _currentLevelTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankItem.currentLevelTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankItem.progressTxt");
         _seasonRewardHox = ComponentFactory.Instance.creatComponentByStylename("guildFBRankItem.seasonRewardHox");
         addChild(_rankTxt);
         addChild(_guildNameTxt);
         addChild(_currentLevelTxt);
         addChild(_progressTxt);
         addChild(_seasonRewardHox);
      }
      
      private function unInitView() : void
      {
         if(_rankTxt)
         {
            ObjectUtils.disposeObject(_rankTxt);
         }
         _rankTxt = null;
         if(_guildNameTxt)
         {
            ObjectUtils.disposeObject(_guildNameTxt);
         }
         _guildNameTxt = null;
         if(_currentLevelTxt)
         {
            ObjectUtils.disposeObject(_currentLevelTxt);
         }
         _currentLevelTxt = null;
         if(_progressTxt)
         {
            ObjectUtils.disposeObject(_progressTxt);
         }
         _progressTxt = null;
         if(_seasonRewardHox)
         {
            ObjectUtils.disposeObject(_seasonRewardHox);
         }
         _seasonRewardHox = null;
      }
      
      public function dispose() : void
      {
         unInitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

