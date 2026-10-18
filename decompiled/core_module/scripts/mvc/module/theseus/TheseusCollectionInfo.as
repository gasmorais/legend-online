package mvc.module.theseus
{
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusCollectionInfo
   {
      
      public var Id:int;
      
      public var _star:int = 0;
      
      public var chipNum:int;
      
      public var isPassive:Boolean = false;
      
      public var chipId:int;
      
      public var chipNeedNum:int;
      
      public var quality:int;
      
      public var templeteInfo:GoodsTemplateInfo;
      
      private var _starInfo:TheseusCollectionStarInfo;
      
      private var _starnextInfo:TheseusCollectionStarInfo;
      
      public function TheseusCollectionInfo()
      {
         super();
      }
      
      public function get star() : int
      {
         return _star;
      }
      
      public function set star(param1:int) : void
      {
         _star = param1;
         _starInfo = TempleteManager.instance.collectionTempCate.getTemplateByID(Id,_star + 1);
         if(_star == 0 && !isPassive)
         {
            _starnextInfo = TempleteManager.instance.collectionTempCate.getTemplateByID(Id,_star + 1);
         }
         else
         {
            _starnextInfo = TempleteManager.instance.collectionTempCate.getTemplateByID(Id,_star + 2);
         }
         if(_starnextInfo)
         {
            _starnextInfo.setChip();
         }
      }
      
      public function get starInfo() : TheseusCollectionStarInfo
      {
         return _starInfo;
      }
      
      public function get starnextInfo() : TheseusCollectionStarInfo
      {
         return _starnextInfo;
      }
      
      public function get starMaxInfo() : TheseusCollectionStarInfo
      {
         return TempleteManager.instance.collectionTempCate.getTemplateByID(Id,11);
      }
   }
}

