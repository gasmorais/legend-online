package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.planeswar.info.PlanesInfo;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesRewardTip extends BaseTip
   {
      
      private var titleText:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      private var vBox:VBox;
      
      public function PlanesRewardTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = ComponentFactory.Instance.creatComponentByStylename("planesRewardTip.titleText");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         vBox = new VBox();
         vBox.spacing = 2;
         addChild(titleText);
         addChild(_line1);
         addChild(vBox);
         _line1.width = 200;
         _line1.y = 35;
         vBox.x = 5;
         vBox.y = 40;
         titleText.text = LanguageMgr.GetTranslation("PlanesRewardTip.titleText");
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:Object = null;
         var _loc2_:PlanesInfo = null;
         var _loc1_:PlanesRewardItemTip = null;
         vBox.removeAllChild();
         if(_data)
         {
            if(_data.hasOwnProperty("dic") && _data.dic)
            {
               for(var _loc4_:String in _data.dic)
               {
                  _loc3_ = {};
                  _loc2_ = PlanesWarManager.instance.model.getPlanesInfoById(int(_loc4_));
                  _loc3_.planesTempId = _loc2_.planesTemId;
                  _loc3_.dic = _data.dic[_loc4_];
                  _loc1_ = new PlanesRewardItemTip();
                  _loc1_.data = _loc3_;
                  vBox.addChild(_loc1_);
               }
            }
         }
         this._bg.height = vBox.height + 60;
      }
      
      override public function dispose() : void
      {
         if(titleText)
         {
            ObjectUtils.disposeObject(titleText);
         }
         titleText = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         if(vBox)
         {
            vBox.removeAllChild();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

