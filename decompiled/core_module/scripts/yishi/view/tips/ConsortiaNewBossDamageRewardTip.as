package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaNewBossDamageRewardTemplateInfo;
   
   public class ConsortiaNewBossDamageRewardTip extends BaseTip
   {
      
      private var _hbox:HBox;
      
      private var _titleTxt:FilterFrameText;
      
      private var _selfDamageTxt1:FilterFrameText;
      
      private var _selfDamageTxt2:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _spliteBmp1:ScaleBitmapImage;
      
      private var _spliteBmp2:ScaleBitmapImage;
      
      public function ConsortiaNewBossDamageRewardTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceNameText");
         _selfDamageTxt1 = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceDescribeText");
         _selfDamageTxt2 = ComponentFactory.Instance.creatComponentByStylename("tips.consortianewBoss.selfDamageTxt2");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
         _spliteBmp1 = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         _spliteBmp2 = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         addChild(_titleTxt);
         _titleTxt.y = 5;
         _titleTxt.width = 85;
         addChild(_selfDamageTxt1);
         _selfDamageTxt1.x = 8;
         _selfDamageTxt1.y = 35;
         addChild(_selfDamageTxt2);
         _selfDamageTxt2.x = 70;
         _selfDamageTxt2.y = 35;
         addChild(_rewardTxt);
         _rewardTxt.x = 10;
         _rewardTxt.y = 60;
         addChild(_spliteBmp1);
         _spliteBmp1.y = 30;
         addChild(_spliteBmp2);
         _spliteBmp1.y = 57;
         _hbox = new HBox();
         _hbox.spacing = 3;
         _hbox.x = 5;
         _hbox.y = 85;
         addChild(_hbox);
         _selfDamageTxt1.width = 60;
         _titleTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.ConsortiaNewBossDamageRewardTip.titleTxt");
         _selfDamageTxt1.text = LanguageMgr.GetTranslation("yishi.view.tips.ConsortiaNewBossDamageRewardTip.selfDamageTxt1");
         _rewardTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.TaskTraceTip.rewardItem");
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:Object = null;
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:TaskTraceRewardItem = null;
         var _loc5_:GoodsInfo = null;
         if(_hbox)
         {
            _hbox.disposeAllChildren();
         }
         if(tipData)
         {
            _loc6_ = tipData as Object;
            if(_loc6_)
            {
               _loc4_ = _loc6_.damageReward;
               _loc1_ = int(_loc6_.damage);
               _selfDamageTxt2.text = _loc1_.toString();
               if(_selfDamageTxt2.textWidth + 12 < 80)
               {
                  _selfDamageTxt2.width = _selfDamageTxt2.textWidth + 12;
               }
               _loc3_ = 0;
               while(_loc3_ < _loc4_.length)
               {
                  _loc2_ = new TaskTraceRewardItem();
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = (_loc4_[_loc3_] as ConsortiaNewBossDamageRewardTemplateInfo).itemId;
                  _loc5_.count = (_loc4_[_loc3_] as ConsortiaNewBossDamageRewardTemplateInfo).count;
                  _loc2_.data = _loc5_;
                  _hbox.addChild(_loc2_);
                  _loc3_++;
               }
            }
            _bg.width = 116;
            _bg.width = _selfDamageTxt1.textWidth + _selfDamageTxt2.textWidth + 20;
            if(_spliteBmp1)
            {
               _spliteBmp1.width = 110;
            }
            if(_spliteBmp2)
            {
               _spliteBmp2.width = 110;
            }
            if(_bg.width < _hbox.width)
            {
               _bg.width = _hbox.width + 10;
               if(_spliteBmp1)
               {
                  _spliteBmp1.width = _bg.width - 3;
               }
               if(_spliteBmp2)
               {
                  _spliteBmp2.width = _bg.width - 3;
               }
            }
            _bg.height = 160;
         }
      }
      
      override public function dispose() : void
      {
         _hbox = null;
         _titleTxt = null;
         _selfDamageTxt1 = null;
         _selfDamageTxt2 = null;
         _rewardTxt = null;
         _spliteBmp1 = null;
         _spliteBmp2 = null;
         super.dispose();
      }
   }
}

