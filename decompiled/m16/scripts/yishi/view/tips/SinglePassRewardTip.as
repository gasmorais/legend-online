package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.singlepass.SinglePassTipData;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SinglePassAreaRewardData;
   import yishi.datas.templates.SinglePassBossRewardData;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SinglePassRewardTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      public function SinglePassRewardTip()
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
         var _loc4_:SinglePassTipData = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc1_:FilterFrameText = null;
         var _loc3_:ScaleBitmapImage = null;
         if(tipData)
         {
            _vBox.removeAllChild();
            _loc4_ = tipData as SinglePassTipData;
            if(_loc4_.type == 0)
            {
               for each(_loc2_ in _loc4_.drops1)
               {
                  _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.ItemId);
                  if(_loc6_)
                  {
                     _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc1_.setFrame(_loc6_.Profile);
                     _loc1_.text = _loc6_.TemplateName + "*" + _loc2_.Count;
                     _vBox.addChild(_loc1_);
                  }
               }
            }
            else if(_loc4_.type == 1)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               _vBox.addChild(_loc1_);
               for each(_loc5_ in _loc4_.drops1)
               {
                  if(_loc5_.Type == 0)
                  {
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        _vBox.addChild(_loc1_);
                     }
                  }
               }
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt2");
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt02");
               _vBox.addChild(_loc1_);
               for each(_loc5_ in _loc4_.drops1)
               {
                  if(_loc5_.Type == 2)
                  {
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        _vBox.addChild(_loc1_);
                     }
                  }
               }
            }
            else if(_loc4_.type == 2)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt2");
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt03");
               _vBox.addChild(_loc1_);
               for each(_loc5_ in _loc4_.drops1)
               {
                  if(_loc5_.Type == 2)
                  {
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        _vBox.addChild(_loc1_);
                     }
                  }
               }
            }
            else if(_loc4_.type == 3)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               _vBox.addChild(_loc1_);
               for each(_loc5_ in _loc4_.drops1)
               {
                  if(_loc5_.Type == 1)
                  {
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        _vBox.addChild(_loc1_);
                     }
                  }
               }
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
               _vBox.addChild(_loc3_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
               _loc1_.x = 0;
               _loc1_.text = LanguageMgr.GetTranslation("yishi.view.tips.SinglePassRewardTip.firstKill");
               _vBox.addChild(_loc1_);
               for each(_loc5_ in _loc4_.drops2)
               {
                  if(_loc5_.Type == 3)
                  {
                     _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        _vBox.addChild(_loc1_);
                     }
                  }
               }
               if(!StringHelper.isNullOrEmpty(_loc4_.firstName))
               {
                  _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                  _loc1_.setFrame(8);
                  _loc1_.text = LanguageMgr.GetTranslation("yishi.view.tips.SinglePassRewardTip.hasGetBy",_loc4_.firstName);
                  _vBox.addChild(_loc1_);
               }
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
               _vBox.addChild(_loc3_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
               _loc1_.x = 0;
               _loc1_.text = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt05");
               _vBox.addChild(_loc1_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc1_.setFrame(8);
               _loc1_.text = _loc4_.maxScore + "";
               _vBox.addChild(_loc1_);
            }
            _vBox.refreshChildPos();
            _bg.width = _vBox.displayWidth + 20;
            _bg.height = _vBox.displayHeight + 20;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

