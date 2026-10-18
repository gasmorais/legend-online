package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MonsterManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MonsterAccessoriesTipsContent extends Sprite implements Disposeable
   {
      
      private static const PROP_MODULUS:Number = 0.05;
      
      private var _equipIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _totalBox:VBox;
      
      private var _subBox1:VBox;
      
      private var _contain1:Sprite;
      
      private var _contain2:Sprite;
      
      private var _type:FilterFrameText;
      
      private var _gradesText:FilterFrameText;
      
      private var _intensifyText:FilterFrameText;
      
      private var _wearGradesTxt:FilterFrameText;
      
      private var _baseLine:Bitmap;
      
      private var _subBox2:VBox;
      
      private var _propLine:Bitmap;
      
      private var _subBox3:VBox;
      
      private var _effectTitleTxt:FilterFrameText;
      
      private var _effectTxt:FilterFrameText;
      
      private var _contain3:Sprite;
      
      private var _effectLine:Bitmap;
      
      private var _subBox4:VBox;
      
      private var _endLine:Bitmap;
      
      private var _send:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      private var _effectItemList:Vector.<MonsterAccessoriesTipsItem>;
      
      public function MonsterAccessoriesTipsContent()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _type = ComponentFactory.Instance.creatComponentByStylename("tips.GoodTypeText_2");
         _gradesText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodVocationText");
         _intensifyText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodIntensifyText_2");
         _wearGradesTxt = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _subBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox");
         _subBox3 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox3");
         _subBox4 = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSubBox3");
         _baseLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _propLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _effectLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _endLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _effectTitleTxt = ComponentFactory.Instance.creatComponentByStylename("tip.MonsterAccessoriesTips.effectTitleTxt");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("tip.MonsterAccessoriesTips.effectTxt");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _contain1 = new Sprite();
         _contain1.addChild(_gradesText);
         _contain1.addChild(_type);
         _contain2 = new Sprite();
         _contain2.addChild(_intensifyText);
         _contain2.addChild(_wearGradesTxt);
         _subBox1.addChild(_contain1);
         _subBox1.addChild(_contain2);
         addChild(_equipIcon);
         addChild(_profileImg);
         _profileImg.setFrame(1);
         addChild(_title);
         addChild(_totalBox);
         _totalBox.y = 58;
         initEffect();
      }
      
      private function initEffect() : void
      {
         var _loc1_:MonsterAccessoriesTipsItem = null;
         var _loc2_:int = 0;
         _effectItemList = new Vector.<MonsterAccessoriesTipsItem>();
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc1_ = new MonsterAccessoriesTipsItem(_loc2_);
            _loc1_.x = 15;
            _subBox4.addChild(_loc1_);
            _effectItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _totalBox.removeAllChild();
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc2_:GoodsTemplateInfo = param1.templateInfo;
         _equipIcon.icon = IconFactory.getGoodsIconByTID(_loc2_.TemplateId);
         _profileImg.setFrame(_loc2_.Profile);
         _title.setFrame(_loc2_.Profile);
         _title.text = _loc2_.TemplateName;
         _type.text = LanguageMgr.GetTranslation("MonsterAccessoriesTips.job" + _data.templateInfo.Property6);
         var _loc3_:int = int(param1.strengthenGrade > 0 ? param1.strengthenGrade : 1);
         _gradesText.text = LanguageMgr.GetTranslation("public.level2",_loc3_);
         _intensifyText.text = _loc2_.StrengthenMax == 0 ? "" : LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.intensify",_loc2_.StrengthenMax);
         _wearGradesTxt.text = LanguageMgr.GetTranslation("MonsterAccessoriesTipsContent.wearGradesTxt.text",_loc2_.NeedGrades);
         _effectTitleTxt.text = LanguageMgr.GetTranslation("MonsterAccessoriesTipsContent.effectTitleTxt.text");
         _effectTxt.text = LanguageMgr.GetTranslation("MonsterAccessoriesTipsContent.effectTxt.text");
         _effectTxt.height = _effectTxt.textHeight + 5;
         _totalBox.addChild(_subBox1);
         _totalBox.addChild(_baseLine);
         refreshProp();
         refreshEffect();
         _send.text = "shift+" + LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
         _totalBox.addChild(_send);
      }
      
      private function refreshProp() : void
      {
         var _loc5_:FilterFrameText = null;
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _subBox2.removeAllChild();
         var _loc7_:Array = _data.templateInfo.hasValueAttResi;
         _loc3_ = 0;
         while(_loc3_ < _loc7_.length)
         {
            _loc6_ = _loc7_[_loc3_];
            _loc1_ = int(_data.templateInfo[_loc6_]);
            _loc2_ = int(_data.strengthenGrade > 0 ? _data.strengthenGrade : 1);
            _loc4_ = _loc1_ + 0.05 * (_loc2_ - 1) * _loc1_;
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("tip.MonsterAccessoriesTips.mainAttText");
            _loc5_.text = LanguageMgr.GetTranslation("MonsterAccessoriesView.mainAttText.text" + _loc6_,_loc4_);
            _subBox2.addChild(_loc5_);
            _loc3_++;
         }
         _totalBox.addChild(_subBox2);
         _totalBox.addChild(_propLine);
      }
      
      private function refreshEffect() : void
      {
         var _loc4_:MonsterAccessoriesTipsItem = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc1_:int = model.getEffectSonType(_data);
         if(_loc1_ != 0)
         {
            _loc5_ = 1;
            while(_loc5_ <= _effectItemList.length)
            {
               _loc4_ = _effectItemList[_loc5_ - 1];
               _loc7_ = int(_data["randomSkill" + _loc5_]);
               if(_loc7_ > 0)
               {
                  _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc7_);
                  _loc4_.data = _loc6_;
               }
               if(_loc4_.data)
               {
                  if(_loc4_.data.SonType == _loc1_)
                  {
                     _loc4_.icon.setFrame(2);
                     _loc2_.push(_loc4_.data.Grades);
                  }
                  else
                  {
                     _loc4_.icon.setFrame(1);
                  }
               }
               _loc5_++;
            }
            _loc3_ = model.getEffectTxt(_loc1_,_loc2_);
            if(_loc3_ != "")
            {
               _effectTxt.text = _loc3_;
               _effectTxt.height = _effectTxt.textHeight + 5;
            }
         }
         _subBox3.removeAllChild();
         _subBox3.addChild(_effectTitleTxt);
         _subBox3.addChild(_effectTxt);
         _totalBox.addChild(_subBox3);
         _totalBox.addChild(_effectLine);
         _totalBox.addChild(_subBox4);
         _totalBox.addChild(_endLine);
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

