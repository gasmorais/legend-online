package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class FoisonHornRewardTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _goodsTxt:FilterFrameText;
      
      public function FoisonHornRewardTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg.width = 380;
         _title = ComponentFactory.Instance.creatComponentByStylename("foisonHorn.tips.titleTxt");
         _content = ComponentFactory.Instance.creatComponentByStylename("foisonHorn.tips.contentTxt");
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("foisonHorn.tips.goodsTxt");
         addChild(_title);
         addChild(_content);
         addChild(_goodsTxt);
         _title.text = LanguageMgr.GetTranslation("foisonHornRewardTips.titleTxt");
         _content.text = LanguageMgr.GetTranslation("foisonHornRewardTips.contentTxt");
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:Array = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         if(_data is String)
         {
            _loc2_ = _data.split("|");
            _loc6_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = _loc2_[_loc3_].split(",");
               if(_loc1_.length == 2)
               {
                  _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc1_[0]));
                  if(_loc5_)
                  {
                     if(_loc6_ != "")
                     {
                        _loc6_ += "\n";
                     }
                     _loc4_ = GoodsHelp.getGoodColorString(_loc5_.Profile);
                     _loc6_ += "<font color=" + _loc4_ + ">" + _loc5_.TemplateName + " *" + _loc1_[1] + "</font>";
                  }
               }
               _loc3_++;
            }
            _goodsTxt.height = Math.max(20 * _loc2_.length,20);
            _goodsTxt.htmlText = _loc6_;
            _bg.height = _goodsTxt.y + _goodsTxt.height;
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_goodsTxt)
         {
            ObjectUtils.disposeObject(_goodsTxt);
         }
         _goodsTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

