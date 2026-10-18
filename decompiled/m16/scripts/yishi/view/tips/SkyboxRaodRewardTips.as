package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class SkyboxRaodRewardTips extends BaseTip
   {
      
      private var _vBox:VBox;
      
      public function SkyboxRaodRewardTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassVBox");
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:Array = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc1_:FilterFrameText = null;
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         if(tipData != "")
         {
            _vBox.removeAllChild();
            _loc2_ = String(tipData).split("|");
            if(_loc2_[0] == "1")
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               _vBox.addChild(_loc1_);
            }
            _loc4_ = 1;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = String(_loc2_[_loc4_]).split(",");
               switch(_loc3_[1])
               {
                  case -100:
                  case -700:
                  case -1200:
                     break;
                  default:
                     _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_[1]);
                     if(_loc5_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc5_.Profile);
                        _loc1_.text = _loc5_.TemplateName + "*" + _loc3_[2];
                        _vBox.addChild(_loc1_);
                     }
               }
               _loc4_++;
            }
            _vBox.refreshChildPos();
            _bg.width = _vBox.displayWidth + 20;
            _bg.height = _vBox.displayHeight + 20;
         }
      }
   }
}

