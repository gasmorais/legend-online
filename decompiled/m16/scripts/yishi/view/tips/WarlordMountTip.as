package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.WildSoulInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class WarlordMountTip extends BaseTip
   {
      
      private var _txt01:FilterFrameText;
      
      private var _txt02:FilterFrameText;
      
      private var _txt03:FilterFrameText;
      
      private var _txt04:FilterFrameText;
      
      private var _txt05:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _txtNoOpen:FilterFrameText;
      
      public function WarlordMountTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt01 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt01");
         _txt02 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt02");
         _txt03 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt03");
         _txt04 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         _txt05 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt04");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         _txtNoOpen = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt05");
         addChild(_txt01);
         addChild(_txt02);
         addChild(_txt03);
         addChild(_txt04);
         addChild(_scoreTxt);
         addChild(_txt05);
         addChild(_txtNoOpen);
      }
      
      override protected function updateTransform() : void
      {
         var _loc10_:MountTemplate = null;
         var _loc1_:WildSoulInfo = null;
         var _loc2_:Array = null;
         var _loc5_:String = null;
         var _loc9_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc7_:String = null;
         _txt01.htmlText = "";
         _txt02.htmlText = "";
         _txt03.htmlText = "";
         _txt04.htmlText = "";
         _txt05.htmlText = "";
         _txtNoOpen.htmlText = "";
         _scoreTxt.htmlText = "";
         if(tipData)
         {
            if(tipData is String)
            {
               _txtNoOpen.text = tipData as String;
               _bg.height = 40;
               _bg.width = 195;
            }
            if(tipData is MountTemplate)
            {
               _loc10_ = tipData as MountTemplate;
               _loc1_ = MountsManager.instance.avatarList.getWildSoulInfo(_loc10_.TemplateId);
               _loc2_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips01").split("|");
               _loc5_ = "";
               _loc9_ = 0;
               if(_loc10_.MountType == 1)
               {
                  _loc9_ = int(_loc10_.Speed);
               }
               _loc6_ = [_loc10_.Power,_loc10_.Intellect,_loc10_.Physique,_loc10_.Agility,_loc10_.ExpandLevel,_loc9_];
               if(_loc2_.length >= _loc6_.length)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length)
                  {
                     if(_loc6_[_loc4_] != 0)
                     {
                        _loc5_ += StringHelper.format(_loc2_[_loc4_],_loc6_[_loc4_]) + "<br/>";
                     }
                     _loc4_++;
                  }
               }
               _scoreTxt.htmlText = LanguageMgr.GetTranslation("mountTip.soulscore",_loc10_.SoulScore);
               if(_loc10_.MountType == 0)
               {
                  if(_loc1_)
                  {
                     _txt01.htmlText = _loc10_.TemplateName;
                     _txt03.htmlText = _loc10_.Description;
                     _scoreTxt.y = _txt01.y + _txt01.textHeight + 10;
                     if(_scoreTxt.textHeight == 0)
                     {
                        _txt03.y = _scoreTxt.y;
                     }
                     else
                     {
                        _txt03.y = _scoreTxt.y + _scoreTxt.textHeight + 10;
                     }
                     if(_scoreTxt.textHeight == 0 && _txt03.textHeight == 0)
                     {
                        _bg.height = _txt03.y + _txt03.textHeight + 5;
                     }
                     else
                     {
                        _bg.height = _txt03.y + _txt03.textHeight + 15;
                     }
                  }
                  else
                  {
                     _txtNoOpen.text = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips03",_loc10_.Property2);
                     _scoreTxt.htmlText = "";
                     _bg.height = 40;
                  }
               }
               else
               {
                  _txt01.htmlText = _loc10_.TemplateName;
                  _txt02.htmlText = _loc5_;
                  _txt03.htmlText = _loc10_.Description;
                  _loc3_ = [];
                  if(_loc10_.NeedMountGrade > 0)
                  {
                     _loc3_.push(LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.NeedGrade",_loc10_.NeedMountGrade));
                  }
                  if(_loc10_.NeedItemId != 0)
                  {
                     _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc10_.NeedItemId);
                     if(_loc8_)
                     {
                        _loc3_.push(_loc8_.TemplateName);
                     }
                  }
                  _loc7_ = _loc3_.join("\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                  _txt04.htmlText = LanguageMgr.GetTranslation("mounts.MountTip.NeedGood",_loc7_);
                  if(_loc10_.validity != 0)
                  {
                     if(_loc10_.validity < 0)
                     {
                        _txt05.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.forever");
                     }
                     else
                     {
                        _txt05.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips02",_loc10_.validity);
                     }
                  }
                  else
                  {
                     _txt05.htmlText = "";
                  }
                  _txt02.y = _txt01.y + _txt01.textHeight + 10;
                  if(_txt02.textHeight == 0)
                  {
                     _scoreTxt.y = _txt02.y;
                  }
                  else
                  {
                     _scoreTxt.y = _txt02.y + _txt02.textHeight + 10;
                  }
                  _scoreTxt.y = _txt02.y + _txt02.textHeight + 10;
                  if(_scoreTxt.textHeight == 0)
                  {
                     _txt03.y = _scoreTxt.y;
                  }
                  else
                  {
                     _txt03.y = _scoreTxt.y + _scoreTxt.textHeight + 10;
                  }
                  if(_txt03.textHeight == 0)
                  {
                     _txt04.y = _txt03.y;
                  }
                  else
                  {
                     _txt04.y = _txt03.y + _txt03.textHeight + 10;
                  }
                  if(_txt04.textHeight == 0)
                  {
                     _txt05.y = _txt04.y;
                  }
                  else
                  {
                     _txt05.y = _txt04.y + _txt04.textHeight + 10;
                  }
                  if(_txt05.textHeight == 0)
                  {
                     _bg.height = _txt05.y + 5;
                  }
                  else
                  {
                     _bg.height = _txt05.y + _txt05.textHeight + 15;
                  }
               }
               _bg.width = 195;
            }
         }
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      override public function dispose() : void
      {
         _txt01 = null;
         _txt02 = null;
         _txt03 = null;
         _txt04 = null;
         _txt05 = null;
         _scoreTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

