package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.road.yishi.proto.active.OreItemInfoMsg;
   import com.road.yishi.proto.active.OreRewardTempMsg;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   
   public class StokesOreGoodsShowTip extends BaseTip
   {
      
      private var _rewardTxtTitle:FilterFrameText;
      
      private var _hbox:HBox;
      
      public function StokesOreGoodsShowTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _rewardTxtTitle = ComponentFactory.Instance.creatComponentByStylename("tips.stokesOreGoodsShowTip.rewaredTitle");
         _hbox = new HBox();
         _hbox.spacing = 3;
         _hbox.x = 5;
         _hbox.y = 25;
         addChild(_rewardTxtTitle);
         addChild(_hbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:OreRewardTempMsg = null;
         var _loc6_:GoodsInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:TaskTraceRewardItem = null;
         if(_hbox)
         {
            _hbox.disposeAllChildren();
         }
         if(tipData)
         {
            _loc1_ = tipData as OreRewardTempMsg;
            if(!_loc1_)
            {
               return;
            }
            _loc2_ = [];
            for each(var _loc5_:OreItemInfoMsg in _loc1_.rewards)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc5_.templateId;
               _loc6_.count = _loc5_.count;
               _loc2_.push(_loc6_);
            }
            _loc2_.sort(sortFun);
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = new TaskTraceRewardItem();
               _loc3_.data = _loc2_[_loc4_];
               _hbox.addChild(_loc3_);
               _loc4_++;
            }
            _bg.width = 100;
            if(_bg.width < _hbox.width)
            {
               _bg.width = _hbox.width + 20;
            }
            _bg.height = 110;
            _rewardTxtTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.rewardTxtTitle");
            _rewardTxtTitle.x = (_bg.width - _rewardTxtTitle.width) / 2;
         }
      }
      
      private function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = param1.templateInfo.SonType;
         var _loc4_:int = param2.templateInfo.SonType;
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         return 0;
      }
   }
}

