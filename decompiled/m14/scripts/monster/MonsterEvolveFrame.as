package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import monster.item.MonsterIconCell;
   import monster.item.MonsterShowAvatar;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MonsterManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterEvolveFrame extends Frame implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _nameText:FilterFrameText;
      
      private var _starHbox:HBox;
      
      private var _avatar:MonsterShowAvatar;
      
      private var _skillIcon:BaseIconView;
      
      private var _goldText:FilterFrameText;
      
      private var _noNewSkillText:FilterFrameText;
      
      private var _materialBox:SimpleTileList;
      
      private var materialList:Vector.<MonsterIconCell>;
      
      private var _bagList:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var bagList:Vector.<MonsterIconCell>;
      
      private var _evolveBtn:IconButton;
      
      private var _data:MonsterInfo;
      
      private var tempInfo:MonsterTempInfo;
      
      private var preStar:int;
      
      private var needGold:Number = 0;
      
      public function MonsterEvolveFrame()
      {
         super();
         initView();
         initMaterialView();
         initBagView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,507,521);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.back");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.nameText");
         _materialBox = ComponentFactory.Instance.creatCustomObject("MonsterEvolveFrame.materialBox",[3]);
         _bagList = ComponentFactory.Instance.creatCustomObject("MonsterEvolveFrame.SimpleTileList",[5]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.EquipScrollPanel");
         _evolveBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.evolveBtn");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("MonsterEvolveFrame.skillIcon");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.starHbox");
         _goldText = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.goldText");
         _noNewSkillText = ComponentFactory.Instance.creatComponentByStylename("MonsterEvolveFrame.noNewSkillText");
         _avatar = new MonsterShowAvatar();
         _avatar.mouseChildren = _avatar.mouseEnabled = false;
         addToContent(_back);
         addToContent(_avatar);
         addToContent(_nameText);
         addToContent(_starHbox);
         addToContent(_skillIcon);
         addToContent(_noNewSkillText);
         addToContent(_materialBox);
         addToContent(_bagScroll);
         addToContent(_goldText);
         addToContent(_evolveBtn);
         _bagScroll.setView(_bagList);
      }
      
      private function initMaterialView() : void
      {
         var _loc1_:MonsterIconCell = null;
         var _loc2_:int = 0;
         materialList = new Vector.<MonsterIconCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new MonsterIconCell(2,true);
            _loc1_.evolveFrame = true;
            _loc1_.index = _loc2_ + 1;
            _materialBox.addChild(_loc1_);
            materialList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initBagView() : void
      {
         var _loc1_:MonsterIconCell = null;
         var _loc2_:* = 0;
         bagList = new Vector.<MonsterIconCell>();
         _bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 70)
         {
            _loc1_ = new MonsterIconCell(1);
            _loc1_.evolveFrame = true;
            _loc1_.index = 1;
            _bagList.addChild(_loc1_);
            bagList.push(_loc1_);
            _loc2_++;
         }
         _bagList.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMonsterHandler);
         _evolveBtn.addEventListener("click",__evolveClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MONSTER_BAG_MOVE",this,__updateMoveHandler);
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMonsterHandler);
         if(_evolveBtn)
         {
            _evolveBtn.removeEventListener("click",__evolveClickHandler);
         }
      }
      
      private function __evolveClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(!model.checkCanEvolve(data))
         {
            return;
         }
         var _loc2_:Array = model.getMonsterIds(model.monsterMaterialList);
         if(_loc2_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterEvolveFrame.noMonster.alert"));
            return;
         }
         if(_loc2_.length < data.star)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("monster.monsterEvolve.needAlert",data.star,data.star));
            return;
         }
         if(ResourceManager.instance.gold.count < needGold)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
            return;
         }
         MonsterManager.instance.sendMonsterEvolve(data.monsterId,_loc2_);
      }
      
      private function __updateMoveHandler(param1:String, param2:Object) : void
      {
         this.data = model.monsterDic[data.monsterId];
      }
      
      private function __updateMonsterHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 16)
         {
            dispose();
         }
      }
      
      public function get data() : MonsterInfo
      {
         return _data;
      }
      
      public function set data(param1:MonsterInfo) : void
      {
         _data = param1;
         if(!param1)
         {
            return;
         }
         tempInfo = TempleteManager.instance.monsterTempCate.getTemplateByTypeAndStar(data.type,data.star + 1);
         if(!tempInfo)
         {
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Bitmap = null;
         refreshBagView();
         var _loc3_:Array = tempInfo.SkillSonTypes.split(",");
         if(tempInfo.Star <= _loc3_.length)
         {
            _loc1_ = int(_loc3_[tempInfo.Star - 1]);
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(_loc1_,1);
         }
         if(_loc5_)
         {
            _skillIcon.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            _skillIcon.tipData = _loc5_;
            _noNewSkillText.text = "";
         }
         else
         {
            _skillIcon.icon = null;
            _skillIcon.tipData = null;
            _noNewSkillText.text = LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         }
         _nameText.text = data.name;
         if(preStar != tempInfo.Star)
         {
            _starHbox.removeAllChild();
            _loc4_ = 0;
            while(_loc4_ < tempInfo.Star)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.MonsterPropView.starBitmap");
               _starHbox.addChild(_loc2_);
               _loc4_++;
            }
            _avatar.data = tempInfo;
            _avatar.setBodyScale(tempInfo.Scale / 100);
            _avatar.x = _avatar.getPosLeg().x + 120;
            _avatar.y = _avatar.getPosLeg().y + 195 + tempInfo.Offset;
         }
         preStar = tempInfo.Star;
         needGold = model.getSkillPracticeNeedGold(model.monsterMaterialList);
         _goldText.text = needGold + "";
      }
      
      private function refreshBagView() : void
      {
         var _loc3_:int = 0;
         var _loc5_:MonsterInfo = null;
         var _loc4_:int = 0;
         var _loc6_:MonsterInfo = null;
         clearBagView();
         var _loc1_:Array = model.getMonsterBagShowList();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc3_] as MonsterInfo;
            bagList[_loc3_].data = _loc5_;
            _loc3_++;
         }
         _bagScroll.invalidateViewport();
         var _loc2_:Array = model.monsterMaterialList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_] as MonsterInfo;
            materialList[_loc4_].data = _loc6_;
            _loc4_++;
         }
         _bagScroll.invalidateViewport();
      }
      
      private function clearBagView() : void
      {
         for each(var _loc1_:MonsterIconCell in bagList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:MonsterIconCell in materialList)
         {
            _loc2_.data = null;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("MonsterEvolveFrame.title.text");
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.resetMonsterBagList();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_materialBox);
         _materialBox = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         ObjectUtils.disposeObject(_evolveBtn);
         _evolveBtn = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_goldText);
         _goldText = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         ObjectUtils.disposeObject(_noNewSkillText);
         _noNewSkillText = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         LogicUtils.disposeDisplayCollection(bagList);
         bagList = null;
         super.dispose();
      }
   }
}

