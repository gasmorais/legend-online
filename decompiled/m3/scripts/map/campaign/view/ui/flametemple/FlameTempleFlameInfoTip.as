package map.campaign.view.ui.flametemple
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.data.CampaignArmy;
   import yishi.utils.StringHelper;
   import yishi.view.tips.BaseTip;
   
   public class FlameTempleFlameInfoTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _teamId:int;
      
      public function FlameTempleFlameInfoTip(param1:int = 1)
      {
         super();
         _teamId = param1;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("FlameTempleFlameInfoTip.vBox");
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc4_:int = 0;
         var _loc7_:CampaignArmy = null;
         var _loc1_:HBox = null;
         var _loc5_:FilterFrameText = null;
         var _loc3_:FilterFrameText = null;
         var _loc2_:String = null;
         ObjectUtils.disposeAllChildren(_vBox);
         if(!tipData)
         {
            return;
         }
         var _loc6_:Array = tipData as Array;
         if(!_loc6_ || _loc6_.length == 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc4_] as CampaignArmy;
            _loc1_ = new HBox();
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("FlameTempleFlameInfoTip.txt");
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("FlameTempleFlameInfoTip.txt2");
            _loc2_ = _teamId == 1 ? "4dbbee" : "ff0b2d";
            _loc5_.htmlText = StringHelper.format("<u><font color=\'#{0}\'>{1}</font></u>",_loc2_,_loc7_.nickName);
            _loc3_.text = LanguageMgr.GetTranslation("flameTempleFlameInfoTip.hasFlame");
            _loc1_.addChild(_loc5_);
            _loc1_.addChild(_loc3_);
            _vBox.addChild(_loc1_);
            _loc4_++;
         }
         _bg.width = _vBox.width + 20;
         _bg.height = _vBox.height + 15;
      }
      
      override public function dispose() : void
      {
         _vBox = null;
         super.dispose();
      }
   }
}

