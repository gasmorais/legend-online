package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountKingInfo;
   import mvc.module.mounts.WildSoulInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.base.StarBar;
   
   public class MountTip extends BaseTip
   {
      
      private var _txt01:FilterFrameText;
      
      private var _txt02:FilterFrameText;
      
      private var _txt03:FilterFrameText;
      
      private var _txt04:FilterFrameText;
      
      private var _txt05:FilterFrameText;
      
      private var _txt06:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _lvlText:FilterFrameText;
      
      private var _areaType:ScaleFrameImage;
      
      private var _txtNoOpen:FilterFrameText;
      
      private var _starBar:StarBar;
      
      public function MountTip()
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
         _txt06 = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt06");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         _txtNoOpen = ComponentFactory.Instance.creatComponentByStylename("mounts.wildsoulTipTxt05");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("mounts.curlvlText");
         _areaType = ComponentFactory.Instance.creatComponentByStylename("mounts.areaType");
         _starBar = new StarBar();
         _starBar.x = _txt01.x;
         _lvlText.x = _txt01.x;
         _areaType.y = _txt01.y;
         addChild(_txt01);
         addChild(_starBar);
         addChild(_lvlText);
         addChild(_txt02);
         addChild(_txt03);
         addChild(_txt04);
         addChild(_scoreTxt);
         addChild(_txt05);
         addChild(_txt06);
         addChild(_txtNoOpen);
         addChild(_areaType);
      }
      
      override protected function updateTransform() : void
      {
         var _loc23_:MountTemplate = null;
         var _loc2_:WildSoulInfo = null;
         var _loc9_:MountKingInfo = null;
         var _loc7_:PlayerInfo = null;
         var _loc20_:ConfigInfosTempInfo = null;
         var _loc5_:Array = null;
         var _loc4_:Array = null;
         var _loc21_:String = null;
         var _loc13_:int = 0;
         var _loc18_:Array = null;
         var _loc10_:Array = null;
         var _loc24_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc17_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc8_:int = 0;
         var _loc19_:Array = null;
         var _loc22_:GoodsTemplateInfo = null;
         var _loc12_:String = null;
         _txt01.htmlText = "";
         _txt02.htmlText = "";
         _txt03.htmlText = "";
         _txt04.htmlText = "";
         _txt05.htmlText = "";
         _txt06.htmlText = "";
         _txtNoOpen.htmlText = "";
         _scoreTxt.htmlText = "";
         _starBar.visible = false;
         _lvlText.visible = false;
         _areaType.setFrame(1);
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
               _loc23_ = tipData as MountTemplate;
               _loc2_ = MountsManager.instance.avatarList.getWildSoulInfo(_loc23_.TemplateId);
               _loc9_ = MountsManager.instance.avatarList.getMountKingInfo(_loc23_.TemplateId);
               _loc7_ = PlayerManager.instance.currentPlayerModel.playerInfo;
               _loc20_ = TempleteManager.instance.getConfigInfoByConfigName("mount_king_level_add_property");
               _loc5_ = _loc20_.ConfigValue.split(",");
               if(MountsManager.instance.canShowStar(_loc23_.TemplateId))
               {
                  _starBar.visible = true;
                  _starBar.count = _loc23_.maxStarGrade;
                  _starBar.progress = _loc2_.star;
               }
               _loc4_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips01").split("|");
               _loc21_ = "";
               _loc13_ = int(_loc23_.Speed);
               _loc18_ = [0,0,0,0];
               _loc10_ = [_loc23_.Power,_loc23_.Intellect,_loc23_.Physique,_loc23_.Agility,_loc23_.ExpandLevel,_loc13_];
               if(_loc2_ && _loc23_.MountType != 4 && _loc2_.star > 0)
               {
                  _loc24_ = parseInt(_loc23_.starAddList[_loc2_.star - 1]);
                  _loc18_ = [_loc24_,_loc24_,_loc24_,_loc24_];
               }
               else if(_loc23_.MountType == 4 && _loc9_)
               {
                  _lvlText.text = LanguageMgr.GetTranslation("public.level2",_loc9_.grade);
                  _lvlText.visible = true;
                  _loc16_ = _loc23_.Power + _loc9_.grade * parseInt(_loc5_[0]);
                  _loc3_ = _loc23_.Intellect + _loc9_.grade * parseInt(_loc5_[1]);
                  _loc11_ = _loc23_.Physique + _loc9_.grade * parseInt(_loc5_[2]);
                  _loc1_ = _loc23_.Agility + _loc9_.grade * parseInt(_loc5_[3]);
                  _loc6_ = _loc16_ * _loc9_.extraStar * 0.01;
                  _loc17_ = _loc3_ * _loc9_.extraStar * 0.01;
                  _loc14_ = _loc11_ * _loc9_.extraStar * 0.01;
                  _loc15_ = _loc1_ * _loc9_.extraStar * 0.01;
                  _loc18_ = [_loc6_,_loc17_,_loc14_,_loc15_];
                  _loc10_ = [_loc16_,_loc3_,_loc11_,_loc1_,_loc23_.ExpandLevel,_loc13_];
               }
               if(_loc4_.length >= _loc10_.length)
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc10_.length)
                  {
                     if(_loc8_ < 4)
                     {
                        if(!(_loc10_[_loc8_] == 0 && _loc18_[_loc8_] == 0))
                        {
                           _loc21_ += StringHelper.format(_loc4_[_loc8_],_loc10_[_loc8_]);
                           if(_loc18_[_loc8_] != 0)
                           {
                              _loc21_ += " +" + _loc18_[_loc8_] + "<br/>";
                           }
                           else
                           {
                              _loc21_ += "<br/>";
                           }
                        }
                     }
                     else if(_loc10_[_loc8_] != 0)
                     {
                        _loc21_ += StringHelper.format(_loc4_[_loc8_],_loc10_[_loc8_]) + "<br/>";
                     }
                     _loc8_++;
                  }
               }
               _scoreTxt.htmlText = LanguageMgr.GetTranslation("mountTip.soulscore",_loc23_.SoulScore);
               _areaType.setFrame(_loc23_.Area + 1);
               if(_loc23_.MountType == 0)
               {
                  if(_loc2_)
                  {
                     _txt01.htmlText = _loc23_.TemplateName;
                     _txt02.htmlText = _loc21_;
                     _txt03.htmlText = _loc23_.Description;
                     if(_starBar.visible)
                     {
                        _starBar.y = _txt01.y + _txt01.textHeight + 5;
                        _txt02.y = _txt01.y + _txt01.textHeight + 32;
                     }
                     else if(_lvlText.visible)
                     {
                        _lvlText.y = _txt01.y + _txt01.textHeight + 8;
                        _txt02.y = _txt01.y + _txt01.textHeight + 32;
                     }
                     else
                     {
                        _txt02.y = _txt01.y + _txt01.textHeight + 10;
                     }
                     if(_txt02.textHeight == 0)
                     {
                        _scoreTxt.y = _txt02.y;
                     }
                     else
                     {
                        _scoreTxt.y = _txt02.y + _txt02.textHeight + 10;
                     }
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
                        _txt06.y = _txt03.y;
                     }
                     else
                     {
                        _txt06.y = _txt03.y + _txt03.textHeight + 10;
                     }
                     if(isFlying(_loc23_.TemplateId))
                     {
                        _txt06.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips06");
                     }
                     else
                     {
                        _txt06.htmlText = "";
                     }
                     if(_scoreTxt.textHeight == 0 && _txt03.textHeight == 0 && _txt06.textHeight == 0)
                     {
                        _bg.height = _txt06.y + _txt06.textHeight + 5;
                     }
                     else
                     {
                        _bg.height = _txt06.y + _txt06.textHeight + 15;
                     }
                  }
                  else
                  {
                     _txtNoOpen.text = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips03",_loc23_.Property2);
                     _scoreTxt.htmlText = "";
                     _bg.height = 40;
                  }
               }
               else
               {
                  _txt01.htmlText = _loc23_.TemplateName;
                  _txt02.htmlText = _loc21_;
                  _txt03.htmlText = _loc23_.Description;
                  _loc19_ = [];
                  if(_loc23_.NeedMountGrade > 0)
                  {
                     _loc19_.push(LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.NeedGrade",_loc23_.NeedMountGrade));
                  }
                  if(_loc23_.NeedItemId != 0)
                  {
                     _loc22_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc23_.NeedItemId);
                     if(_loc22_)
                     {
                        _loc19_.push(_loc22_.TemplateName);
                     }
                  }
                  if(_loc23_.MountType == 3)
                  {
                     if(ArmyManager.instance.thane.IsVipAndNoExpirt)
                     {
                        _txt04.htmlText = "";
                        _txt05.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.VIPMountsTips");
                     }
                     else
                     {
                        _txt04.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.VIPMountsNeedTips");
                        _txt05.htmlText = "";
                     }
                  }
                  else
                  {
                     if(_loc2_ == null && _loc19_.length > 0)
                     {
                        _loc12_ = _loc19_.join("\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                        _txt04.htmlText = LanguageMgr.GetTranslation("mounts.MountTip.NeedGood",_loc12_);
                     }
                     if(_loc2_ && _loc2_.validity != 0)
                     {
                        if(_loc2_.validity < 0)
                        {
                           _txt05.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.forever");
                        }
                        else
                        {
                           _txt05.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips02",_loc2_.validity);
                        }
                     }
                     else
                     {
                        _txt05.htmlText = "";
                     }
                  }
                  if(isFlying(_loc23_.TemplateId))
                  {
                     _txt06.htmlText = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips06");
                  }
                  else
                  {
                     _txt06.htmlText = "";
                  }
                  if(_starBar.visible)
                  {
                     _starBar.y = _txt01.y + _txt01.textHeight + 5;
                     _txt02.y = _txt01.y + _txt01.textHeight + 32;
                  }
                  else if(_lvlText.visible)
                  {
                     _lvlText.y = _txt01.y + _txt01.textHeight + 8;
                     _txt02.y = _txt01.y + _txt01.textHeight + 32;
                  }
                  else
                  {
                     _txt02.y = _txt01.y + _txt01.textHeight + 10;
                  }
                  if(_txt02.textHeight == 0)
                  {
                     _scoreTxt.y = _txt02.y;
                  }
                  else
                  {
                     _scoreTxt.y = _txt02.y + _txt02.textHeight + 10;
                  }
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
                     _txt06.y = _txt05.y;
                  }
                  else
                  {
                     _txt06.y = _txt05.y + _txt05.textHeight + 10;
                  }
                  if(_txt06.textHeight == 0)
                  {
                     _bg.height = _txt06.y + 5;
                  }
                  else
                  {
                     _bg.height = _txt06.y + _txt06.textHeight + 15;
                  }
               }
               _bg.width = Math.max(205,_txt01.textWidth + 50);
            }
            _areaType.x = _bg.width - 30;
         }
      }
      
      public function isFlying(param1:int) : Boolean
      {
         var _loc2_:MountTemplate = TempleteManager.instance.mountTemplateDic[param1];
         if(_loc2_ && (_loc2_.IsFly == 1 || Boolean(_loc2_.isBuyFly)))
         {
            return true;
         }
         return false;
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
         _txt06 = null;
         _scoreTxt = null;
         _areaType = null;
         _lvlText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

