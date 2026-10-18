package childarena
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildArenaRewardTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ChildArenaRewardItem extends Component
   {
      
      private var rankImage:ScaleFrameImage;
      
      private var rewardHbox:HBox;
      
      private var index:int;
      
      public function ChildArenaRewardItem(param1:int)
      {
         super();
         index = param1;
         initView();
         initRewardListView();
      }
      
      private function initView() : void
      {
         rankImage = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRewardItem.rankImage");
         rewardHbox = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRewardItem.rewardHbox");
         addChild(rankImage);
         addChild(rewardHbox);
         rankImage.setFrame(index);
      }
      
      private function initRewardListView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:ChildArenaRewardTemplateInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:int = int(ChildManager.instance.arenaModel.arenaType);
         var _loc2_:int = 5 - index;
         var _loc7_:Array = TempleteManager.instance.childArenaRewardTempCate.getTemplatesByTypeAndRank(_loc6_,_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc7_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildArenaRewardItem.item");
            _loc3_ = _loc7_[_loc4_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc3_.itemId;
            _loc5_.count = _loc3_.count;
            _loc1_.data = _loc5_;
            rewardHbox.addChild(_loc1_);
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(rankImage);
         rankImage = null;
         ObjectUtils.disposeObject(rewardHbox);
         rewardHbox = null;
         super.dispose();
      }
   }
}

