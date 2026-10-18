package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.gamehall.GameHallGameInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class GameHallActiveRewardView extends Sprite
   {
      
      private var _rewardBg:Image;
      
      private var _rewardDiff1:Image;
      
      private var _rewardDiff2:Image;
      
      private var _rewardDiffBg1:Image;
      
      private var _rewardDiffBg2:Image;
      
      private var _rewardContainer:Sprite;
      
      private var _rewardContainer1:Sprite;
      
      private var _rewardContainer2:Sprite;
      
      private var _rewardList:Vector.<BaseItemView>;
      
      private var _rewardList1:Vector.<BaseItemView>;
      
      private var _rewardList2:Vector.<BaseItemView>;
      
      public function GameHallActiveRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:BaseItemView = null;
         _rewardBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRewardView.rewardBg");
         _rewardDiff1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRewardView.rewardDiff1");
         _rewardDiff2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRewardView.rewardDiff2");
         _rewardDiffBg1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRewardView.rewardDiffBg1");
         _rewardDiffBg2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallActiveRewardView.rewardDiffBg2");
         _rewardContainer = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.rewardContainer");
         _rewardContainer1 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.rewardContainer1");
         _rewardContainer2 = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.rewardContainer2");
         _rewardBg.visible = false;
         _rewardDiff1.visible = false;
         _rewardDiff2.visible = false;
         _rewardDiffBg1.visible = false;
         _rewardDiffBg2.visible = false;
         _rewardContainer.visible = false;
         _rewardContainer1.visible = false;
         _rewardContainer2.visible = false;
         addChild(_rewardBg);
         addChild(_rewardDiff1);
         addChild(_rewardDiff2);
         addChild(_rewardDiffBg1);
         addChild(_rewardDiffBg2);
         addChild(_rewardContainer);
         addChild(_rewardContainer1);
         addChild(_rewardContainer2);
         _rewardList = new Vector.<BaseItemView>();
         _rewardList1 = new Vector.<BaseItemView>();
         _rewardList2 = new Vector.<BaseItemView>();
         var _loc3_:int = 0;
         var _loc1_:int = 4;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.itemView");
            _loc2_.x = _loc3_ % 2 * 90;
            _loc2_.y = int(_loc3_ / 2) * 70;
            _rewardContainer.addChild(_loc2_);
            _rewardList.push(_loc2_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.itemView");
            _loc2_.x = _loc3_ * 60;
            _loc2_.y = 0;
            _rewardContainer1.addChild(_loc2_);
            _rewardList1.push(_loc2_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallActiveRewardView.itemView");
            _loc2_.x = _loc3_ * 60;
            _loc2_.y = 0;
            _rewardContainer2.addChild(_loc2_);
            _rewardList2.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function uninitView() : void
      {
         var _loc1_:BaseItemView = null;
         if(_rewardList)
         {
            for each(_loc1_ in _rewardList)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         if(_rewardList1)
         {
            for each(_loc1_ in _rewardList1)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         if(_rewardList2)
         {
            for each(_loc1_ in _rewardList2)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         ObjectUtils.disposeAllChildren(_rewardContainer);
         ObjectUtils.disposeAllChildren(_rewardContainer1);
         ObjectUtils.disposeAllChildren(_rewardContainer2);
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_rewardDiff1);
         _rewardDiff1 = null;
         ObjectUtils.disposeObject(_rewardDiff2);
         _rewardDiff2 = null;
         ObjectUtils.disposeObject(_rewardDiffBg1);
         _rewardDiffBg1 = null;
         ObjectUtils.disposeObject(_rewardDiffBg2);
         _rewardDiffBg2 = null;
         ObjectUtils.disposeObject(_rewardContainer);
         _rewardContainer = null;
         ObjectUtils.disposeObject(_rewardContainer1);
         _rewardContainer1 = null;
         ObjectUtils.disposeObject(_rewardContainer2);
         _rewardContainer2 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _rewardList = null;
         _rewardList1 = null;
         _rewardList2 = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refreshView(param1:GameHallGameInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         if(param1 && param1.templateInfo)
         {
            _loc4_ = 0;
            _loc3_ = 0;
            if(param1.templateInfo.hasDiffSelect)
            {
               _rewardBg.visible = false;
               _rewardContainer.visible = false;
               _rewardDiff1.visible = true;
               _rewardDiff2.visible = true;
               _rewardDiffBg1.visible = true;
               _rewardDiffBg2.visible = true;
               _rewardContainer1.visible = true;
               _rewardContainer2.visible = true;
               _loc2_ = param1.templateInfo.ShowItems.split("|");
               _loc5_ = (_loc2_[0] as String).split(",");
               _loc3_ = int(_loc5_.length);
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  _loc6_ = new GoodsInfo();
                  if(_loc4_ < _loc3_)
                  {
                     _loc6_.templateId = int(_loc5_[_loc4_]);
                     _rewardList1[_loc4_].data = _loc6_;
                  }
                  else
                  {
                     _rewardList1[_loc4_].data = null;
                  }
                  _loc4_++;
               }
               _loc5_ = (_loc2_[1] as String).split(",");
               _loc3_ = int(_loc5_.length);
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  _loc6_ = new GoodsInfo();
                  if(_loc4_ < _loc3_)
                  {
                     _loc6_.templateId = int(_loc5_[_loc4_]);
                     _rewardList2[_loc4_].data = _loc6_;
                  }
                  else
                  {
                     _rewardList2[_loc4_].data = null;
                  }
                  _loc4_++;
               }
            }
            else
            {
               _rewardBg.visible = true;
               _rewardContainer.visible = true;
               _rewardDiff1.visible = false;
               _rewardDiff2.visible = false;
               _rewardDiffBg1.visible = false;
               _rewardDiffBg2.visible = false;
               _rewardContainer1.visible = false;
               _rewardContainer2.visible = false;
               _loc5_ = param1.templateInfo.ShowItems.split(",");
               _loc3_ = int(_loc5_.length);
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  _loc6_ = new GoodsInfo();
                  if(_loc4_ < _loc3_)
                  {
                     _loc6_.templateId = int(_loc5_[_loc4_]);
                     _rewardList[_loc4_].data = _loc6_;
                  }
                  else
                  {
                     _rewardList[_loc4_].data = null;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

