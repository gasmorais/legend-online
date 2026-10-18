package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.PlanesTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class PlanesRewardItemTip extends Sprite implements Disposeable
   {
      
      private var planesName:FilterFrameText;
      
      private var _resiText:FilterFrameText;
      
      private var rewardsGoodsHbox:HBox;
      
      private var _line:ScaleBitmapImage;
      
      private var rewardsDic:SimpleDictionary;
      
      public function PlanesRewardItemTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         planesName = ComponentFactory.Instance.creatComponentByStylename("planesRewardTip.planesNameText");
         _resiText = ComponentFactory.Instance.creatComponentByStylename("planesRewardTip.resiText");
         rewardsGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("planesRewardTip.rewardsGoodsHbox");
         _line = ComponentFactory.Instance.creatComponentByStylename("tips.HeroTipLine1");
         addChild(planesName);
         addChild(_resiText);
         addChild(rewardsGoodsHbox);
         addChild(_line);
         _line.width = 200;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc4_:PlanesTemplateInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         rewardsGoodsHbox.removeAllChild();
         var _loc7_:String = LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText");
         if(param1.hasOwnProperty("dic") && param1.dic)
         {
            _loc4_ = TempleteManager.instance.planesTemplateCate.getTemplateByID(param1.planesTempId);
            planesName.text = _loc4_.PlanesName;
            rewardsDic = param1.dic;
         }
         for(var _loc8_:String in rewardsDic)
         {
            if(_loc8_)
            {
               if(parseInt(_loc8_) >= 1 && parseInt(_loc8_) <= 7)
               {
                  if(rewardsDic[_loc8_] != 0)
                  {
                     _loc7_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText" + _loc8_,rewardsDic[_loc8_]) + "  ";
                  }
               }
               else
               {
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("planesRewardTip.BaseItemView");
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = parseInt(_loc8_);
                  _loc5_.count = rewardsDic[_loc8_];
                  _loc2_.data = _loc5_;
                  rewardsGoodsHbox.addChild(_loc2_);
               }
            }
         }
         var _loc3_:Boolean = false;
         _loc6_ = 1;
         while(_loc6_ < 8)
         {
            if(rewardsDic[_loc6_] && rewardsDic[_loc6_] != 0)
            {
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(!_loc3_)
         {
            _resiText.htmlText = "";
         }
         else
         {
            _resiText.htmlText = _loc7_;
         }
         _resiText.height = _resiText.textHeight + 5;
         _resiText.y = planesName.y + planesName.textHeight + 5;
         rewardsGoodsHbox.y = _resiText.y + _resiText.height + 5;
         _line.y = rewardsGoodsHbox.y + rewardsGoodsHbox.height + 5;
      }
      
      public function dispose() : void
      {
         if(rewardsGoodsHbox)
         {
            rewardsGoodsHbox.removeAllChild();
            ObjectUtils.disposeObject(rewardsGoodsHbox);
            rewardsGoodsHbox = null;
         }
         if(planesName)
         {
            ObjectUtils.disposeObject(planesName);
         }
         planesName = null;
         if(_resiText)
         {
            ObjectUtils.disposeObject(_resiText);
         }
         _resiText = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

