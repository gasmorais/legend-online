package map.campaign.view.ui
{
   import battle.view.ui.top.BossInfoView;
   
   public class WorldBossInfoView extends BossInfoView
   {
      
      public function WorldBossInfoView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         addChild(_assetRight);
         bloodTxt.visible = true;
         bloodTxt.text = "";
      }
      
      override public function setCurrentHp(param1:Number) : void
      {
         super.setCurrentHp(param1);
         bloodTxt.text = param1 + " / " + _rightHp.maxValue;
      }
   }
}

